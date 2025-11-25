import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Local - Gestión de Productos'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'Gestión de Productos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'API Local con Node.js y MariaDB',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/products');
              },
              icon: const Icon(Icons.list),
              label: const Text('Ver Lista de Productos'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/categories');
              },
              icon: const Icon(Icons.category),
              label: const Text('Gestión de Categorías'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
