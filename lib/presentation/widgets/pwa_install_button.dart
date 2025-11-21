import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PWAInstallButton extends StatelessWidget {
  const PWAInstallButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          const Icon(Icons.download, color: Colors.blue),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Installer l\'application pour une meilleure expérience',
              style: TextStyle(fontSize: 14),
            ),
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Pour installer l\'application, utilisez le menu de votre navigateur (Chrome: Menu > Installer l\'application)',
                  ),
                  duration: Duration(seconds: 5),
                ),
              );
            },
            child: const Text('Installer'),
          ),
        ],
      ),
    );
  }
}

