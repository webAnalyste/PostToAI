# Email à envoyer à WordPress.org

## 📧 Demande de changement de slug

Vous devez **répondre à l'email d'approbation** que vous avez reçu pour demander le changement de slug.

---

## ✉️ Modèle d'email (en anglais)

**Sujet (Subject) :** Request to change plugin slug before first deployment

**Corps du message :**

```
Hello,

Thank you for approving my plugin "Fscan - Post to AI".

Before making the first deployment, I would like to request a change of the plugin slug from:
- Current approved slug: expansai-post-to-ai
- Requested new slug: fscan-post-to-ai

The plugin name will remain "Fscan - Post to AI".

This change is needed to better align with my branding (Fscan is my username and brand name).

Since this is before the first deployment, I believe this change should be possible without affecting any existing users.

Could you please:
1. Update the SVN repository URL to: https://plugins.svn.wordpress.org/fscan-post-to-ai
2. Update the public URL to: https://wordpress.org/plugins/fscan-post-to-ai

Thank you for your assistance!

Best regards,
Franck Scandolera (fscan)
```

---

## 📋 Informations à fournir si demandé

- **Ancien slug :** expansai-post-to-ai
- **Nouveau slug :** fscan-post-to-ai
- **Nom du plugin :** Fscan - Post to AI
- **Raison :** Alignement avec la marque personnelle (Fscan)

---

## ⏱️ Délai de réponse

WordPress.org répond généralement sous **24-72 heures**.

---

## 🔄 En attendant la réponse

**NE PAS déployer** tant que WordPress.org n'a pas confirmé le changement de slug.

Une fois confirmé, vous pourrez exécuter :
```bash
./deploy-wordpress-org.sh
```

---

## 📞 Comment répondre

**Répondez directement à l'email d'approbation** que vous avez reçu avec le sujet :
"Congratulations, the plugin hosting request for expansAI Post to AI has been approved."

---

**Important :** Gardez tous vos fichiers tels quels (slug `fscan-post-to-ai`). Une fois WordPress.org aura créé le repository, le déploiement fonctionnera.
