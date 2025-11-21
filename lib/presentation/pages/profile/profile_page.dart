import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/cart_viewmodel.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.blue.shade100,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.email ?? 'Utilisateur',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (user?.emailVerified == false)
                            const Text(
                              'Email non vérifié',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text('Mes commandes'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go('/orders'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Panier'),
              trailing: Consumer<CartViewModel>(
                builder: (context, cart, _) {
                  if (cart.itemCount > 0) {
                    return Chip(
                      label: Text('${cart.itemCount}'),
                      backgroundColor: Colors.blue.shade100,
                    );
                  }
                  return const Icon(Icons.chevron_right);
                },
              ),
              onTap: () => context.go('/cart'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Catalogue'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go('/catalog'),
            ),
            const SizedBox(height: 32),
            Consumer<AuthViewModel>(
              builder: (context, authViewModel, _) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await authViewModel.signOut();
                      if (context.mounted) {
                        context.go('/login');
                      }
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Déconnexion'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

