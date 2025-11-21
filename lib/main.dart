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
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2196F3),
            brightness: Brightness.light,
          ),
          cardTheme: CardThemeData(
            elevation: 2,
            shadowColor: Colors.black.withValues(alpha: 0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 2,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: false,
          ),
          typography: Typography.material2021(),
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
