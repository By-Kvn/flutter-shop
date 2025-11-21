import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/pages/auth/login_page.dart';
import '../../presentation/pages/auth/register_page.dart';
import '../../presentation/pages/catalog/catalog_page.dart';
import '../../presentation/pages/catalog/product_detail_page.dart';
import '../../presentation/pages/cart/cart_page.dart';
import '../../presentation/pages/checkout/checkout_page.dart';
import '../../presentation/pages/orders/orders_page.dart';
import '../../presentation/pages/profile/profile_page.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) {
    final isLoggedIn = _firebaseAuth.currentUser != null;
    final isGoingToLogin = state.matchedLocation == '/login' ||
        state.matchedLocation == '/register';

    if (!isLoggedIn && !isGoingToLogin) {
      return '/login';
    }

    if (isLoggedIn && isGoingToLogin) {
      return '/catalog';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/catalog',
      builder: (context, state) => const CatalogPage(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ProductDetailPage(productId: id);
      },
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartPage(),
    ),
    GoRoute(
      path: '/checkout',
      builder: (context, state) => const CheckoutPage(),
    ),
    GoRoute(
      path: '/orders',
      builder: (context, state) => const OrdersPage(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfilePage(),
    ),
  ],
);

