import 'package:flutter/material.dart';
import 'package:retro_games_museum/screens/store/store_cart_item_tile.dart';

import '../../data/models/cart_item_model.dart';
import '../../data/repositories/store_repository.dart';

class StoreCartScreen extends StatefulWidget {
  const StoreCartScreen({super.key});

  @override
  State<StoreCartScreen> createState() => _StoreCartScreenState();
}

class _StoreCartScreenState extends State<StoreCartScreen> {
  final StoreRepository _storeRepository = StoreRepository();
  List<CartItemModel> _cartItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    try {
      final cartData = await _storeRepository.getCartItems();
      setState(() {
        _cartItems = cartData.map((map) => CartItemModel.fromMap(map)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al cargar el carrito')),
      );
    }
  }

  Future<void> _updateQuantity(CartItemModel item, int newQuantity) async {
    try {
      await _storeRepository.updateCartItemQuantity(item.id!, newQuantity);
      _loadCartItems();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al actualizar cantidad')),
      );
    }
  }

  Future<void> _removeItem(CartItemModel item) async {
    try {
      await _storeRepository.removeFromCart(item.id!);
      _loadCartItems();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al eliminar item')),
      );
    }
  }

  double get _total => _cartItems.fold(
        0,
        (sum, item) => sum + (item.productPrice! * item.quantity),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _cartItems.isEmpty
              ? const Center(child: Text('El carrito está vacío'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _cartItems.length,
                        itemBuilder: (context, index) {
                          final item = _cartItems[index];
                          return StoreCartItemTile(
                            item: item,
                            onUpdateQuantity: _updateQuantity,
                            onRemove: () => _removeItem(item),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, -1),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total: \$${_total.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _showPaymentDialog(context);
                            },
                            child: const Text('Proceder al pago'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pago de Productos'),
          content: const Text("Aquí se implementaría la funcionalidad del pago, pero esta aplicación es de ejemplo."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}