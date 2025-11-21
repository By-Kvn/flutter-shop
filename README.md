# ShopFlutter - Application E-Commerce Complète

Application e-commerce Flutter avec authentification Firebase, architecture Clean/MVVM, et support multi-plateformes (Web, iOS, Android).

> 🚀 **CI/CD activé** : Les tests et le déploiement sont automatisés via GitHub Actions !

## 🚀 Fonctionnalités

- ✅ **Catalogue de produits** avec recherche et filtres par catégorie
- ✅ **Détail produit** avec carousel d'images
- ✅ **Panier** avec gestion des quantités
- ✅ **Checkout** avec paiement mock
- ✅ **Authentification Firebase** (Email/Password)
- ✅ **Historique des commandes** (stockées dans Firestore)
- ✅ **Profil utilisateur**
- ✅ **Spécificités plateformes** :
  - **Web** : PWA avec bouton d'installation
  - **iOS** : Interface Cupertino sur la page détail
  - **Android** : Partage de produits via Share Intent

## 📁 Architecture

Le projet suit une architecture **Clean/MVVM** :

```
lib/
├── core/              # Utilitaires, routes, DI
├── data/              # Data sources, repositories impl, models
├── domain/            # Entities, repositories interfaces, use cases
└── presentation/      # Pages, ViewModels, Widgets
```

## 🛠️ Installation

1. **Cloner le projet**
```bash
cd shop_flutter
```

2. **Installer les dépendances**
```bash
flutter pub get
```

3. **Générer les fichiers de code**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **Configurer Firebase** (optionnel pour tester)
```bash
# Installer flutterfire CLI
dart pub global activate flutterfire_cli

# Configurer Firebase
flutterfire configure
```

> **Note** : Pour tester sans Firebase complet, un fichier `firebase_options.dart` minimal est fourni. L'authentification ne fonctionnera pas sans configuration Firebase réelle.

## 🧪 Tests

### Lancer l'application

**Sur Web (Chrome)** :
```bash
flutter run -d chrome
```

**Sur macOS** :
```bash
flutter run -d macos
```

**Sur iOS Simulator** :
```bash
flutter run -d ios
```

**Sur Android Emulator** :
```bash
flutter run -d android
```

### Tester les fonctionnalités

1. **Authentification** :
   - Créer un compte avec email/password
   - Se connecter
   - Se déconnecter depuis le profil

2. **Catalogue** :
   - Parcourir les produits
   - Rechercher un produit (ex: "iPhone")
   - Filtrer par catégorie (Electronics, Fashion)

3. **Panier** :
   - Ajouter un produit au panier depuis le détail
   - Modifier les quantités
   - Supprimer un produit

4. **Checkout** :
   - Remplir le formulaire de livraison
   - Remplir les informations de paiement (mock)
   - Confirmer la commande

5. **Commandes** :
   - Voir l'historique des commandes
   - Voir les détails d'une commande

6. **Spécificités plateformes** :
   - **Web** : Voir le bouton "Installer l'application" en haut du catalogue
   - **iOS** : La page détail utilise CupertinoPageScaffold
   - **Android** : Utiliser le bouton partage sur la page détail

## 📦 Dépendances principales

- `go_router` : Navigation
- `firebase_auth` : Authentification
- `cloud_firestore` : Base de données
- `provider` : State management
- `get_it` : Dependency injection
- `cached_network_image` : Images en cache
- `share_plus` : Partage (Android)
- `intl` : Formatage de dates

## 🔧 Configuration Firebase

Pour une configuration complète de Firebase :

1. Créer un projet sur [Firebase Console](https://console.firebase.google.com/)
2. Activer Authentication (Email/Password)
3. Créer une base de données Firestore
4. Lancer `flutterfire configure`
5. Les fichiers de configuration seront générés automatiquement

## 📝 Structure des routes

- `/login` - Page de connexion
- `/register` - Page d'inscription
- `/catalog` - Catalogue de produits
- `/product/:id` - Détail d'un produit
- `/cart` - Panier
- `/checkout` - Checkout
- `/orders` - Historique des commandes
- `/profile` - Profil utilisateur

## 🚧 À faire (optionnel)

- [ ] Tests unitaires (5 tests minimum)
- [ ] Tests widget (2 tests minimum)
- [ ] GitHub Actions CI/CD
- [ ] Configuration Firebase complète
- [ ] Google Sign-In (bonus)
- [ ] Stripe pour le paiement (bonus)

## 📄 Licence

Par KEVIN LABATTE
