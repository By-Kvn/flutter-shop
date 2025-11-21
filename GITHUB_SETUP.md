# Instructions pour lier le projet à GitHub

## 1. Créer le dépôt sur GitHub

1. Va sur https://github.com/new
2. Nom du dépôt : `shop-flutter` (ou autre nom de ton choix)
3. Description : "Application e-commerce Flutter avec Firebase Auth, architecture Clean/MVVM"
4. Visibilité : Public ou Private (selon ton choix)
5. **Ne coche PAS** "Initialize with README" (on a déjà un README)
6. Clique sur "Create repository"

## 2. Lier le dépôt local à GitHub

Une fois le dépôt créé, GitHub te donnera une URL comme :
`https://github.com/TON-USERNAME/shop-flutter.git`

### Option A : Via HTTPS (recommandé)
```bash
cd /Users/kevin/Desktop/Flutter-rendu/shop_flutter
git remote add origin https://github.com/TON-USERNAME/shop-flutter.git
git branch -M main
git push -u origin main
```

### Option B : Via SSH (si tu as configuré SSH)
```bash
cd /Users/kevin/Desktop/Flutter-rendu/shop_flutter
git remote add origin git@github.com:TON-USERNAME/shop-flutter.git
git branch -M main
git push -u origin main
```

## 3. Vérifier

Après le push, tu devrais voir tous tes fichiers sur GitHub !

## Notes importantes

- Le fichier `firebase_options.dart` contient des clés de démo. Si tu configures Firebase plus tard, ce fichier sera régénéré avec les vraies clés.
- Le `.gitignore` est déjà configuré pour exclure les fichiers de build et les dépendances.

