# Guide de Déploiement - ShareToAI

Ce guide explique comment déployer automatiquement le plugin ShareToAI sur votre serveur WordPress.

## 📋 Table des Matières

1. [Déploiement Automatique via GitHub Actions](#déploiement-automatique-via-github-actions)
2. [Déploiement Manuel via Script](#déploiement-manuel-via-script)
3. [Configuration des Secrets](#configuration-des-secrets)
4. [Rollback et Récupération](#rollback-et-récupération)

---

## 🤖 Déploiement Automatique via GitHub Actions

### Configuration Initiale

#### 1. Générer une clé SSH

Sur votre machine locale :

```bash
# Générer une nouvelle clé SSH pour le déploiement
ssh-keygen -t ed25519 -C "deploy-sharetoai" -f ~/.ssh/deploy_sharetoai

# Afficher la clé publique
cat ~/.ssh/deploy_sharetoai.pub
```

#### 2. Ajouter la clé publique sur le serveur

Connectez-vous à votre serveur et ajoutez la clé publique :

```bash
# Sur le serveur
mkdir -p ~/.ssh
echo "VOTRE_CLE_PUBLIQUE" >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

#### 3. Configurer les Secrets GitHub

Allez sur votre repository GitHub : `https://github.com/webAnalyste/shareToAI/settings/secrets/actions`

Ajoutez les secrets suivants :

| Secret | Description | Exemple |
|--------|-------------|---------|
| `SSH_PRIVATE_KEY` | Clé privée SSH | Contenu de `~/.ssh/deploy_sharetoai` |
| `REMOTE_HOST` | Adresse du serveur | `votre-serveur.com` |
| `REMOTE_USER` | Utilisateur SSH | `www-data` ou `votre-user` |
| `REMOTE_PATH` | Chemin vers plugins | `/var/www/html/wp-content/plugins` |

**Pour le staging (optionnel)** :
- `STAGING_SSH_PRIVATE_KEY`
- `STAGING_HOST`
- `STAGING_USER`
- `STAGING_PATH`

#### 4. Tester le Déploiement

```bash
# Faire un commit et push
git add .
git commit -m "test: déploiement automatique"
git push origin main
```

Le déploiement se lancera automatiquement ! Suivez la progression dans l'onglet **Actions** de votre repository GitHub.

---

## 🛠️ Déploiement Manuel via Script

### Configuration

1. **Copier le fichier de configuration** :

```bash
cp .env.production.example .env.production
```

2. **Éditer `.env.production`** :

```bash
REMOTE_HOST=votre-serveur.com
REMOTE_USER=votre-utilisateur
REMOTE_PATH=/var/www/html/wp-content/plugins
```

3. **Rendre le script exécutable** :

```bash
chmod +x deploy.sh
```

### Utilisation

```bash
# Déployer en production
./deploy.sh production

# Déployer en staging
./deploy.sh staging
```

Le script va :
- ✅ Créer un backup automatique
- ✅ Synchroniser les fichiers
- ✅ Définir les permissions correctes
- ✅ Vider le cache WordPress (si WP-CLI disponible)

---

## 🔐 Configuration des Secrets

### Méthode 1 : Via l'interface GitHub

1. Allez sur `https://github.com/webAnalyste/shareToAI/settings/secrets/actions`
2. Cliquez sur **New repository secret**
3. Ajoutez chaque secret un par un

### Méthode 2 : Via GitHub CLI

```bash
# Installer GitHub CLI si nécessaire
brew install gh

# Se connecter
gh auth login

# Ajouter les secrets
gh secret set SSH_PRIVATE_KEY < ~/.ssh/deploy_sharetoai
gh secret set REMOTE_HOST -b "votre-serveur.com"
gh secret set REMOTE_USER -b "www-data"
gh secret set REMOTE_PATH -b "/var/www/html/wp-content/plugins"
```

---

## 🔄 Workflows Disponibles

### 1. Deploy to Production (`deploy.yml`)

**Déclenchement** : 
- Push sur la branche `main`
- Déclenchement manuel via l'interface GitHub

**Actions** :
- Backup automatique
- Synchronisation des fichiers
- Configuration des permissions
- Nettoyage du cache

### 2. Deploy to Staging (`deploy-staging.yml`)

**Déclenchement** :
- Push sur les branches `develop` ou `staging`
- Déclenchement manuel

**Utilisation** :
```bash
# Créer une branche de staging
git checkout -b staging
git push origin staging
```

---

## 🚨 Rollback et Récupération

### Restaurer un Backup

Les backups sont créés automatiquement avant chaque déploiement :

```bash
# Se connecter au serveur
ssh user@serveur.com

# Lister les backups
ls -lh /var/www/html/wp-content/plugins/shareToAI-backup-*.tar.gz

# Restaurer un backup
cd /var/www/html/wp-content/plugins/
rm -rf shareToAI/
tar -xzf shareToAI-backup-20260303-161500.tar.gz
```

### Rollback via Git

```bash
# Revenir au commit précédent
git revert HEAD
git push origin main

# Le déploiement automatique se déclenchera avec l'ancienne version
```

---

## 📊 Monitoring du Déploiement

### Vérifier le statut

```bash
# Via GitHub Actions
# Allez sur : https://github.com/webAnalyste/shareToAI/actions

# Via SSH
ssh user@serveur.com "ls -la /var/www/html/wp-content/plugins/shareToAI/"
```

### Logs de déploiement

Les logs sont disponibles dans l'onglet **Actions** de GitHub pour chaque déploiement.

---

## ⚙️ Configuration Avancée

### Déploiement sur plusieurs serveurs

Créez plusieurs workflows avec des secrets différents :

```yaml
# .github/workflows/deploy-server1.yml
# .github/workflows/deploy-server2.yml
```

### Notifications Slack/Discord

Ajoutez à la fin de votre workflow :

```yaml
- name: Notify Slack
  uses: 8398a7/action-slack@v3
  with:
    status: ${{ job.status }}
    webhook_url: ${{ secrets.SLACK_WEBHOOK }}
```

### Tests automatiques avant déploiement

Ajoutez un job de test avant le déploiement :

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: PHP Syntax Check
        run: find . -name "*.php" -exec php -l {} \;
  
  deploy:
    needs: test
    # ... reste du déploiement
```

---

## 🆘 Dépannage

### Erreur : Permission denied (publickey)

```bash
# Vérifier que la clé SSH est correcte
ssh -i ~/.ssh/deploy_sharetoai user@serveur.com

# Vérifier les permissions sur le serveur
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

### Erreur : rsync command not found

```bash
# Installer rsync sur le serveur
sudo apt-get install rsync  # Debian/Ubuntu
sudo yum install rsync      # CentOS/RHEL
```

### Le cache WordPress n'est pas vidé

```bash
# Installer WP-CLI sur le serveur
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
```

---

## 📞 Support

Pour toute question ou problème :
- GitHub Issues : https://github.com/webAnalyste/shareToAI/issues
- Documentation : https://github.com/webAnalyste/shareToAI

---

**Dernière mise à jour** : 2026-03-03
