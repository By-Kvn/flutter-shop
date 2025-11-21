import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'core/utils/app_router.dart';
import 'core/utils/dependency_injection.dart';
import 'presentation/viewmodels/auth_viewmodel.dart';
import 'presentation/viewmodels/cart_viewmodel.dart';
import 'presentation/viewmodels/catalog_viewmodel.dart';
import 'presentation/viewmodels/order_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // If Firebase fails, continue anyway for testing
    debugPrint('Firebase initialization error: $e');
  }
  
  // Setup dependency injection
  setupDependencyInjection();
  
  runApp(const ShopFlutterApp());
}

class ShopFlutterApp extends StatelessWidget {
  const ShopFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => CatalogViewModel()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => OrderViewModel()),
      ],
      child: MaterialApp.router(
        title: 'ShopFlutter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
