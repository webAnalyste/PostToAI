# Diagnostic du Système de Mise à Jour Automatique

**Date** : 7 mars 2026  
**Plugin** : ShareToAI v1.0.3  
**Statut** : ❌ Non fonctionnel

---

## 🔴 Problème Principal Identifié

### Le dépôt GitHub n'est pas accessible publiquement

```bash
# Test effectué
curl -s https://api.github.com/repos/webAnalyste/shareToAI/releases
# Résultat : 404 Not Found
```

**Cause** : Le dépôt `https://github.com/webAnalyste/shareToAI` est soit :
- Privé (non accessible publiquement)
- Inexistant
- Mal orthographié

**Impact** : Le système de mise à jour ne peut pas :
- Vérifier les nouvelles versions
- Télécharger les fichiers ZIP
- Notifier les utilisateurs

---

## ✅ Corrections Appliquées au Code

### 1. Sécurisation de `after_install()`

**Avant** :
```php
public function after_install($response, $hook_extra, $result) {
    global $wp_filesystem;
    $plugin_folder = WP_PLUGIN_DIR . '/' . dirname($this->plugin_slug);
    $wp_filesystem->move($result['destination'], $plugin_folder);
    // Pas de vérification d'erreur
}
```

**Après** :
```php
public function after_install($response, $hook_extra, $result) {
    global $wp_filesystem;
    
    // ✅ Vérification de la destination
    if (!isset($result['destination'])) {
        $this->log('Erreur : destination non définie', 'error');
        return $result;
    }
    
    // ✅ Initialisation sécurisée de WP_Filesystem
    if (!WP_Filesystem()) {
        $this->log('Erreur : impossible d\'initialiser WP_Filesystem', 'error');
        return $result;
    }
    
    // ✅ Vérification de l'existence du dossier source
    if (!$wp_filesystem->exists($result['destination'])) {
        $this->log('Erreur : le dossier source n\'existe pas', 'error');
        return $result;
    }
    
    // ✅ Suppression de l'ancien dossier avant déplacement
    if ($wp_filesystem->exists($plugin_folder)) {
        if (!$wp_filesystem->delete($plugin_folder, true)) {
            $this->log('Erreur : impossible de supprimer l\'ancien dossier', 'error');
            return $result;
        }
    }
    
    // ✅ Déplacement avec vérification
    if (!$wp_filesystem->move($result['destination'], $plugin_folder)) {
        $this->log('Erreur : impossible de déplacer le dossier', 'error');
        return $result;
    }
    
    // ✅ Logs détaillés
}
```

### 2. Ajout de Logs de Debugging

Nouvelle fonction `log()` ajoutée :
```php
private function log($message, $level = 'info') {
    if (!defined('WP_DEBUG_LOG') || !WP_DEBUG_LOG) {
        return;
    }
    
    $formatted_message = sprintf(
        '[ShareToAI Updater] [%s] %s',
        strtoupper($level),
        $message
    );
    
    error_log($formatted_message);
}
```

**Logs ajoutés dans** :
- `check_update()` : détection de nouvelles versions
- `get_remote_version()` : récupération depuis GitHub
- `after_install()` : installation et déplacement

### 3. Gestion d'Erreurs Robuste

**Erreurs HTTP détectées** :
```php
$response_code = wp_remote_retrieve_response_code($response);
if ($response_code !== 200) {
    $this->log(sprintf(
        'Erreur HTTP %d. Le dépôt GitHub est peut-être privé ou inexistant.',
        $response_code
    ), 'error');
    return false;
}
```

**Erreurs JSON détectées** :
```php
if (json_last_error() !== JSON_ERROR_NONE) {
    $this->log('Erreur de décodage JSON : ' . json_last_error_msg(), 'error');
    return false;
}
```

---

## 📋 Actions Requises pour Activer les Mises à Jour

### Étape 1 : Rendre le Dépôt GitHub Public

**Option A - Si le dépôt existe mais est privé** :
1. Aller sur `https://github.com/webAnalyste/shareToAI/settings`
2. Descendre à "Danger Zone"
3. Cliquer sur "Change visibility" → "Make public"

**Option B - Si le dépôt n'existe pas** :
1. Créer le dépôt sur GitHub : `https://github.com/new`
2. Nom : `shareToAI`
3. Visibilité : **Public**
4. Pousser le code actuel :
```bash
cd /Users/fscan/Documents/Dev/shareToAI
git remote add origin https://github.com/webAnalyste/shareToAI.git
git push -u origin main
```

### Étape 2 : Créer les Releases GitHub

Pour chaque version existante, créer une release :

```bash
# Version 1.0.0
gh release create v1.0.0 sharetoai-1.0.0.zip \
  --title "ShareToAI v1.0.0" \
  --notes "Version initiale"

# Version 1.0.1
gh release create v1.0.1 sharetoai-1.0.1.zip \
  --title "ShareToAI v1.0.1" \
  --notes "Corrections mineures"

# Version 1.0.2
gh release create v1.0.2 sharetoai-1.0.2.zip \
  --title "ShareToAI v1.0.2" \
  --notes "Améliorations"

# Version 1.0.3 (actuelle)
gh release create v1.0.3 sharetoai-1.0.3.zip \
  --title "ShareToAI v1.0.3" \
  --notes "Version stable"

# Version 1.1.0
gh release create v1.1.0 sharetoai-1.1.0.zip \
  --title "ShareToAI v1.1.0" \
  --notes "Nouvelles fonctionnalités"
```

**Alternative sans CLI GitHub** :
1. Aller sur `https://github.com/webAnalyste/shareToAI/releases/new`
2. Tag : `v1.0.3`
3. Title : `ShareToAI v1.0.3`
4. Description : Copier depuis `CHANGELOG.md`
5. Attacher le fichier `sharetoai-1.0.3.zip`
6. Cliquer sur "Publish release"

### Étape 3 : Tester le Système

Une fois les releases créées :

```bash
# Vérifier que l'API fonctionne
curl -s https://api.github.com/repos/webAnalyste/shareToAI/releases/latest | jq '.tag_name'
# Devrait afficher : "v1.1.0"

# Vérifier que le ZIP est téléchargeable
curl -I https://github.com/webAnalyste/shareToAI/releases/download/v1.1.0/sharetoai-1.1.0.zip
# Devrait retourner : HTTP/2 302 (redirection vers le fichier)
```

---

## 🧪 Activer les Logs de Debugging

Pour voir les logs détaillés du système de mise à jour :

**1. Activer WP_DEBUG_LOG dans `wp-config.php`** :
```php
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', false);
```

**2. Forcer la vérification des mises à jour** :
```php
// Dans wp-admin, via un plugin temporaire ou la console
delete_transient('sharetoai_remote_version');
delete_transient('sharetoai_changelog');
wp_update_plugins();
```

**3. Consulter les logs** :
```bash
tail -f /path/to/wordpress/wp-content/debug.log | grep "ShareToAI Updater"
```

**Exemples de logs attendus** :
```
[ShareToAI Updater] [INFO] Vérification de la version distante sur : https://api.github.com/repos/webAnalyste/shareToAI/releases/latest
[ShareToAI Updater] [INFO] Version distante trouvée : 1.1.0
[ShareToAI Updater] [INFO] Nouvelle version disponible : 1.1.0 (actuelle : 1.0.3)
```

**En cas d'erreur** :
```
[ShareToAI Updater] [ERROR] Erreur HTTP 404 lors de la récupération de la version distante. Le dépôt GitHub est peut-être privé ou inexistant.
```

---

## 📊 Vérification Post-Correction

### Checklist de Validation

- [ ] Le dépôt GitHub est public
- [ ] Les releases sont créées avec les tags corrects (v1.0.0, v1.0.1, etc.)
- [ ] Les fichiers ZIP sont attachés aux releases
- [ ] L'API GitHub retourne la dernière version
- [ ] WP_DEBUG_LOG est activé
- [ ] Les logs montrent la détection de la version distante
- [ ] La notification de mise à jour apparaît dans WordPress admin
- [ ] La mise à jour s'installe correctement
- [ ] Le plugin se réactive après mise à jour

---

## 🔧 Commandes Utiles

### Vider les caches de mise à jour
```php
delete_transient('sharetoai_remote_version');
delete_transient('sharetoai_changelog');
```

### Forcer la vérification
```php
wp_update_plugins();
```

### Vérifier la version installée
```php
$plugin_data = get_plugin_data(WP_PLUGIN_DIR . '/sharetoai/sharetoai.php');
echo $plugin_data['Version'];
```

---

## 📞 Support

Si le problème persiste après avoir rendu le dépôt public et créé les releases :

1. Vérifier les logs dans `wp-content/debug.log`
2. Tester l'API GitHub manuellement avec `curl`
3. Vérifier que le serveur WordPress peut accéder à GitHub (pas de firewall bloquant)
4. Consulter la documentation : `AUTO-UPDATE.md`

---

**Résumé** : Le code du système de mise à jour est maintenant sécurisé et robuste. Le problème principal est que le dépôt GitHub n'est pas accessible publiquement. Une fois le dépôt rendu public et les releases créées, le système fonctionnera automatiquement.
