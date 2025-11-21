# Guide de déploiement sur Vercel

## Configuration

Le projet est configuré pour être déployé sur Vercel avec le fichier `vercel.json`.

## Déploiement automatique (via GitHub Actions)

Le workflow CI/CD est configuré pour déployer automatiquement sur Vercel à chaque push sur `main`.

**Secrets GitHub requis :**
- `VERCEL_TOKEN` : Token d'API Vercel
- `VERCEL_ORG_ID` : ID de l'organisation Vercel
- `VERCEL_PROJECT_ID` : ID du projet Vercel

## Déploiement manuel

### Option 1 : Via Vercel CLI

```bash
# Installer Vercel CLI
npm install -g vercel

# Se connecter
vercel login

# Déployer
cd shop_flutter
vercel --prod
```

### Option 2 : Via Vercel Dashboard

1. Va sur https://vercel.com/new
2. Importe le dépôt GitHub `By-Kvn/flutter-shop`
3. Configure :
   - **Framework Preset** : Other
   - **Root Directory** : `shop_flutter` (si nécessaire)
   - **Build Command** : `flutter build web --release`
   - **Output Directory** : `build/web`
4. Clique sur **Deploy**

## Vérification du build local

```bash
# Build en mode release
flutter build web --release

# Vérifier les fichiers générés
ls -la build/web/

# Tester localement (optionnel)
cd build/web
python3 -m http.server 8000
# Puis ouvrir http://localhost:8000
```

## Structure du build

Le build génère :
- `index.html` : Point d'entrée
- `main.dart.js` : Code JavaScript compilé
- `assets/` : Assets de l'application
- `canvaskit/` : Bibliothèque CanvasKit pour Flutter Web
- `icons/` : Icônes PWA
- `manifest.json` : Manifest PWA

## Notes importantes

- Le build fait environ 30MB (normal pour Flutter Web)
- Les routes sont gérées par `vercel.json` (toutes les routes → index.html)
- Le cache est configuré pour optimiser les performances
- Firebase doit être configuré avec les bonnes clés pour la production

