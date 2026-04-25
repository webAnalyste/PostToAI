# Assets WordPress.org - Guide de préparation

## 📸 Assets requis pour WordPress.org

Pour que votre plugin soit bien présenté sur WordPress.org, vous devez préparer les assets suivants :

### 1. Screenshots (Captures d'écran)

Les screenshots sont référencés dans `readme.txt` :

```
== Screenshots ==

1. Page de configuration du plugin dans Réglages > expansAI Post to AI
2. Affichage des liens IA en style "Icônes" sur un article
3. Affichage en style "Boutons avec texte"
4. Affichage en style "Liste"
5. Personnalisation du prompt avec placeholder {URL}
```

**Format requis :**
- Fichiers : `screenshot-1.png`, `screenshot-2.png`, etc.
- Format : PNG ou JPG
- Résolution recommandée : 1280x720 pixels (16:9)
- Emplacement : `assets/images/` (seront copiés automatiquement)

### 2. Bannière (Header)

**Bannière principale (obligatoire) :**
- Fichier : `banner-772x250.png` ou `banner-772x250.jpg`
- Dimensions : 772 x 250 pixels
- Affichée en haut de la page du plugin

**Bannière haute résolution (optionnelle) :**
- Fichier : `banner-1544x500.png` ou `banner-1544x500.jpg`
- Dimensions : 1544 x 500 pixels
- Pour les écrans Retina

### 3. Icône (Icon)

**Icône standard (obligatoire) :**
- Fichier : `icon-128x128.png` ou `icon.svg`
- Dimensions : 128 x 128 pixels
- Affichée dans les résultats de recherche

**Icône haute résolution (optionnelle) :**
- Fichier : `icon-256x256.png`
- Dimensions : 256 x 256 pixels
- Pour les écrans Retina

## 📁 Structure des fichiers

Placez tous ces fichiers dans : `/assets/images/`

```
assets/
└── images/
    ├── banner-772x250.png
    ├── banner-1544x500.png (optionnel)
    ├── icon-128x128.png
    ├── icon-256x256.png (optionnel)
    ├── screenshot-1.png
    ├── screenshot-2.png
    ├── screenshot-3.png
    ├── screenshot-4.png
    └── screenshot-5.png
```

## 🎨 Recommandations de design

### Bannière
- Utilisez les couleurs de votre marque
- Incluez le nom du plugin
- Ajoutez un slogan court
- Restez simple et lisible
- Évitez le texte trop petit

### Icône
- Design simple et reconnaissable
- Fonctionne bien en petit format
- Cohérent avec la bannière
- Fond transparent (SVG) ou couleur unie

### Screenshots
- Montrez les fonctionnalités principales
- Interface propre et claire
- Annotations si nécessaire
- Ordre logique (configuration → utilisation)

## ✅ Checklist avant déploiement

- [ ] Screenshots créés (au moins 3-4 recommandés)
- [ ] Bannière 772x250 créée
- [ ] Icône 128x128 créée
- [ ] Tous les fichiers placés dans `assets/images/`
- [ ] Noms de fichiers corrects (screenshot-1.png, banner-772x250.png, etc.)
- [ ] Images optimisées (taille de fichier raisonnable)

## 🚀 Déploiement

Une fois les assets prêts, le script `deploy-wordpress-org.sh` les copiera automatiquement dans le dossier `assets/` du SVN WordPress.org.

## 📚 Ressources

- [Guide officiel des assets](https://developer.wordpress.org/plugins/wordpress-org/plugin-assets/)
- [Exemples de bons plugins](https://wordpress.org/plugins/browse/popular/)

---

**Note :** Vous pouvez déployer le plugin sans les assets visuels, mais ils améliorent grandement la présentation et le taux de téléchargement.
