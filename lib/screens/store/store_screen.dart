import 'package:flutter/material.dart';
import 'package:retro_games_museum/screens/store/store_cart_screen.dart';
import 'package:retro_games_museum/screens/store/store_product_card_screen.dart';

import '../../data/models/product_model.dart';
import '../../data/repositories/store_repository.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final StoreRepository _storeRepository = StoreRepository();
  List<ProductModel> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final productsData = await _storeRepository.getAllProducts();
      setState(() {
        _products =
            productsData.map((map) => ProductModel.fromMap(map)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al cargar los productos')),
      );
    }
  }

  Future<void> _addToCart(ProductModel product) async {
    try {
      await _storeRepository.addToCart(product.id!, 1);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${product.name} agregado al carrito')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al agregar al carrito')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 218, 218),
      appBar: AppBar(
        title: const Text('Tienda'),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 8.0),
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StoreCartScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _products.isEmpty
              ? const Center(child: Text('No hay productos disponibles'))
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final product = _products[index];
                    return StoreProductCard(
                      product: product,
                      onAddToCart: () => _addToCart(product),
                    );
                  },
                ),
    );
  }
}
