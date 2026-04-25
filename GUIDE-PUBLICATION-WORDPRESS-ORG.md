# Guide de publication sur WordPress.org

## 🎉 Félicitations !

Votre plugin **Fscan - Post to AI** a été approuvé par WordPress.org !

**Informations de votre plugin :**
- **Slug :** `fscan-post-to-ai`
- **SVN URL :** https://plugins.svn.wordpress.org/fscan-post-to-ai
- **Public URL :** https://wordpress.org/plugins/fscan-post-to-ai
- **Username SVN :** `fscan`

## 📋 Étapes de publication

### Étape 1 : Configurer votre mot de passe SVN

1. Allez sur : https://wordpress.org/support/users/fscan/
2. Cliquez sur l'onglet **"Account & Security"**
3. Dans la section **"SVN Password"**, générez un nouveau mot de passe
4. **Sauvegardez ce mot de passe** (vous en aurez besoin pour le déploiement)

⚠️ **Important :** Ce mot de passe est différent de votre mot de passe WordPress.org

### Étape 2 : Préparer les assets (optionnel mais recommandé)

Consultez le fichier `WORDPRESS-ORG-ASSETS.md` pour créer :
- Screenshots (captures d'écran)
- Bannière (header)
- Icône

Placez-les dans `assets/images/` avec les noms appropriés.

### Étape 3 : Vérifier les fichiers du plugin

Le plugin contient actuellement :
- ✅ `fscan-post-to-ai.php` (fichier principal)
- ✅ `readme.txt` (description WordPress.org)
- ✅ `uninstall.php` (désinstallation propre)
- ✅ `includes/` (classes PHP)
- ✅ `assets/css/` (styles)
- ✅ `assets/js/` (scripts)
- ✅ `assets/images/` (icônes IA)
- ✅ `languages/` (traductions)

### Étape 4 : Déployer sur WordPress.org

Exécutez le script de déploiement automatisé :

```bash
./deploy-wordpress-org.sh
```

Le script va :
1. ✅ Vérifier que GIT est propre (sécurité)
2. ✅ Demander votre mot de passe SVN
3. ✅ Checkout du repository SVN
4. ✅ Copier les fichiers dans `trunk/`
5. ✅ Copier les assets dans `assets/`
6. ✅ Commiter vers WordPress.org
7. ✅ Créer le tag version 1.0.5

### Étape 5 : Vérifier la publication

Après le déploiement (quelques minutes) :

1. Visitez : https://wordpress.org/plugins/fscan-post-to-ai/
2. Vérifiez que le plugin s'affiche correctement
3. Testez le bouton de téléchargement
4. Vérifiez les screenshots et la bannière

⏱️ **Délai :** Les résultats de recherche peuvent prendre jusqu'à 72h pour être mis à jour.

## 🔄 Mises à jour futures

Pour publier une nouvelle version :

1. **Modifier le code** dans votre projet local
2. **Mettre à jour la version** dans :
   - `fscan-post-to-ai.php` (header + constante)
   - `readme.txt` (Stable tag + Changelog)
3. **Commiter dans GIT** (règle d'or de sécurité)
4. **Modifier la version** dans `deploy-wordpress-org.sh` (ligne `PLUGIN_VERSION`)
5. **Exécuter** `./deploy-wordpress-org.sh`

## 📊 Structure SVN WordPress.org

Votre repository SVN aura cette structure :

```
fscan-post-to-ai/
├── trunk/                    # Version de développement (toujours la dernière)
│   ├── fscan-post-to-ai.php
│   ├── readme.txt
│   ├── uninstall.php
│   ├── includes/
│   ├── assets/
│   └── languages/
├── tags/                     # Versions publiées
│   ├── 1.0.5/
│   ├── 1.0.6/ (future)
│   └── ...
└── assets/                   # Assets WordPress.org (screenshots, bannières)
    ├── banner-772x250.png
    ├── icon-128x128.png
    └── screenshot-*.png
```

## 🛡️ Sécurité et bonnes pratiques

✅ **Toujours respecté par le script :**
- Backup GIT automatique avant déploiement
- Vérification que GIT est propre
- Confirmation avant commit SVN
- Pas de fichiers sensibles (.env, .git, etc.)
- Versioning complet et traçable

## 🆘 Dépannage

### Erreur : "Authentication failed"
→ Vérifiez votre mot de passe SVN sur WordPress.org

### Erreur : "svn: E155037"
→ Le repository SVN existe déjà, supprimez le dossier `../fscan-post-to-ai-svn/`

### Le plugin n'apparaît pas dans les recherches
→ Normal, cela peut prendre jusqu'à 72h

### Erreur : "File not found"
→ Vérifiez que vous êtes dans le bon répertoire du plugin

## 📞 Support

- **Documentation WordPress.org :** https://developer.wordpress.org/plugins/wordpress-org/
- **Forum de support :** https://wordpress.org/support/plugin/fscan-post-to-ai/
- **Votre GitHub :** https://github.com/webAnalyste/shareToAI

## ✅ Checklist finale

Avant de déployer :

- [ ] Mot de passe SVN configuré
- [ ] GIT propre (aucune modification non commitée)
- [ ] Version correcte dans tous les fichiers
- [ ] readme.txt validé (https://wordpress.org/plugins/developers/readme-validator/)
- [ ] Assets préparés (optionnel)
- [ ] Tests effectués en local
- [ ] Changelog mis à jour

---

**Prêt à déployer ?** Exécutez : `./deploy-wordpress-org.sh`
