import '../../core/database_helper.dart';

class StoreRepository  {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertProduct(Map<String, dynamic> product) async {
    final db = await _databaseHelper.database;
    return await db.insert('products', product);
  }

  Future<List<Map<String, dynamic>>> getAllProducts() async {
    final db = await _databaseHelper.database;
    return await db.query('products');
  }

  Future<int> addToCart(int productId, int quantity) async {
    final db = await _databaseHelper.database;
    return await db.insert('cart', {
      'productId': productId,
      'quantity': quantity,
    });
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    final db = await _databaseHelper.database;
    return await db.rawQuery('''
      SELECT cart.*, products.name, products.price 
      FROM cart 
      JOIN products ON cart.productId = products.id
    ''');
  }

  Future<int> removeFromCart(int cartItemId) async {
    final db = await _databaseHelper.database;
    return await db.delete('cart', where: 'id = ?', whereArgs: [cartItemId]);
  }

  Future<int> updateCartItemQuantity(int cartItemId, int quantity) async {
    final db = await _databaseHelper.database;
    return await db.update(
      'cart',
      {'quantity': quantity},
      where: 'id = ?',
      whereArgs: [cartItemId]
    );
  }
}
