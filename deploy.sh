#!/bin/bash

# ShareToAI - Script de déploiement manuel
# Usage: ./deploy.sh [production|staging]

set -e

# Couleurs pour les messages
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Fonction d'affichage
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Vérifier l'environnement
ENVIRONMENT=${1:-production}

if [ "$ENVIRONMENT" != "production" ] && [ "$ENVIRONMENT" != "staging" ]; then
    log_error "Environnement invalide. Utilisez: production ou staging"
    exit 1
fi

log_info "Déploiement vers l'environnement: $ENVIRONMENT"

# Charger les variables d'environnement
if [ -f ".env.$ENVIRONMENT" ]; then
    source ".env.$ENVIRONMENT"
else
    log_error "Fichier .env.$ENVIRONMENT introuvable"
    exit 1
fi

# Vérifier les variables requises
if [ -z "$REMOTE_HOST" ] || [ -z "$REMOTE_USER" ] || [ -z "$REMOTE_PATH" ]; then
    log_error "Variables d'environnement manquantes (REMOTE_HOST, REMOTE_USER, REMOTE_PATH)"
    exit 1
fi

# Confirmation pour la production
if [ "$ENVIRONMENT" = "production" ]; then
    log_warning "Vous êtes sur le point de déployer en PRODUCTION"
    read -p "Êtes-vous sûr ? (oui/non): " confirm
    if [ "$confirm" != "oui" ]; then
        log_info "Déploiement annulé"
        exit 0
    fi
fi

# Créer un backup
log_info "Création d'un backup sur le serveur distant..."
ssh $REMOTE_USER@$REMOTE_HOST "cd $REMOTE_PATH && \
    if [ -d shareToAI ]; then \
        tar -czf shareToAI-backup-\$(date +%Y%m%d-%H%M%S).tar.gz shareToAI/; \
        echo 'Backup créé'; \
    fi" || log_warning "Impossible de créer le backup (le dossier n'existe peut-être pas encore)"

# Synchroniser les fichiers
log_info "Synchronisation des fichiers..."
rsync -avz --delete \
    --exclude='.git' \
    --exclude='.github' \
    --exclude='.gitignore' \
    --exclude='*.md' \
    --exclude='node_modules' \
    --exclude='.DS_Store' \
    --exclude='.env.*' \
    --exclude='deploy.sh' \
    ./ $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH/shareToAI/

log_success "Fichiers synchronisés"

# Définir les permissions
log_info "Configuration des permissions..."
ssh $REMOTE_USER@$REMOTE_HOST "cd $REMOTE_PATH/shareToAI && \
    find . -type f -exec chmod 644 {} \; && \
    find . -type d -exec chmod 755 {} \;"

log_success "Permissions configurées"

# Vider le cache WordPress (si WP-CLI est disponible)
log_info "Nettoyage du cache WordPress..."
ssh $REMOTE_USER@$REMOTE_HOST "cd $REMOTE_PATH/../.. && \
    if command -v wp &> /dev/null; then \
        wp cache flush --allow-root 2>/dev/null || true; \
        echo 'Cache vidé'; \
    else \
        echo 'WP-CLI non disponible, cache non vidé'; \
    fi" || log_warning "Impossible de vider le cache"

# Résumé
echo ""
log_success "========================================="
log_success "Déploiement terminé avec succès !"
log_success "========================================="
log_info "Environnement: $ENVIRONMENT"
log_info "Serveur: $REMOTE_HOST"
log_info "Chemin: $REMOTE_PATH/shareToAI/"
log_info "Date: $(date)"
echo ""
log_warning "N'oubliez pas de tester le plugin sur le site !"
