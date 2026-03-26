import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => CartStore(), child: const MyApp()),
  );
}

class CartStore extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void addToCart() {
    _count++;
    notifyListeners(); // ប្រាប់ Consumber ឲ្យធ្វើការបង្ហាញ UI ថ្មី
  }

  void removeFromCart() {
    if (_count > 0) {
      _count--;
      notifyListeners();
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CartPage());
  }
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          // ✅ context.watch → rebuild AppBar badge
          Badge(
            label: Text('${context.watch<CartStore>().count}'),
            child: const Icon(Icons.shopping_cart),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ Consumer — rebuild only this subtree
            Consumer<CartStore>(
              builder: (_, store, __) => Text(
                'Items in cart: ${store.count}',
                style: const TextStyle(fontSize: 28),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              // ✅ context.read → no rebuild needed in button handler
              onPressed: () => context.read<CartStore>().addToCart(),
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Add to Cart'),
            ),
            TextButton(
              onPressed: () => context.read<CartStore>().removeFromCart(),
              child: const Text('Remove'),
            ),
          ],
        ),
      ),
    );
  }
}
