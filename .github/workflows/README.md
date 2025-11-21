# GitHub Actions CI/CD

Ce dossier contient les workflows GitHub Actions pour automatiser les tests et le déploiement.

## Workflow CI/CD

Le workflow `ci-cd.yml` exécute :

1. **Tests** : Analyse du code, tests unitaires et widget tests avec couverture
2. **Build Web** : Compilation de l'application Flutter pour le web
3. **Déploiement Vercel** : Déploiement automatique sur Vercel (uniquement sur la branche main)

## Configuration requise

### Secrets GitHub

Pour que le déploiement Vercel fonctionne, tu dois ajouter ces secrets dans les paramètres du dépôt GitHub :

1. Va dans **Settings** → **Secrets and variables** → **Actions**
2. Ajoute ces secrets :

   - `VERCEL_TOKEN` : Token d'API Vercel
     - Va sur https://vercel.com/account/tokens
     - Crée un nouveau token
     - Copie-le dans le secret `VERCEL_TOKEN`
   
   - `VERCEL_ORG_ID` : ID de ton organisation Vercel
     - Va sur https://vercel.com/account
     - Trouve ton Organization ID
   
   - `VERCEL_PROJECT_ID` : ID du projet Vercel
     - Crée un projet sur Vercel ou utilise un existant
     - L'ID se trouve dans les paramètres du projet

### Créer un projet Vercel

1. Va sur https://vercel.com
2. Connecte-toi avec GitHub
3. Importe le dépôt `flutter-shop`
4. Configure :
   - **Framework Preset** : Other
   - **Root Directory** : `shop_flutter` (si le projet est dans un sous-dossier)
   - **Build Command** : `flutter build web --release`
   - **Output Directory** : `build/web`
5. Vercel te donnera les IDs nécessaires

### Alternative : Déploiement manuel

Si tu préfères déployer manuellement, tu peux :

1. Build localement : `flutter build web --release`
2. Déployer avec Vercel CLI : `vercel --prod`

## Workflow simplifié (sans Vercel)

Si tu ne veux pas configurer Vercel maintenant, tu peux utiliser le workflow `ci-simple.yml` qui fait seulement les tests et le build.

