import 'package:flutter/material.dart';

import '../../data/models/cart_item_model.dart';

class StoreCartItemTile extends StatelessWidget {
  final CartItemModel item;
  final Function(CartItemModel, int) onUpdateQuantity;
  final VoidCallback onRemove;

  const StoreCartItemTile({
    super.key,
    required this.item,
    required this.onUpdateQuantity,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onRemove(),
      child: ListTile(
        title: Text(item.productName!),
        subtitle: Text('\$${(item.productPrice! * item.quantity).toStringAsFixed(2)}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: item.quantity > 1
                  ? () => onUpdateQuantity(item, item.quantity - 1)
                  : null,
            ),
            Text('${item.quantity}'),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => onUpdateQuantity(item, item.quantity + 1),
            ),
          ],
        ),
      ),
    );
  }
}