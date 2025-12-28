class CartService {
  static List<Map<String, dynamic>> cartItems = [];

  static void addToCart(Map<String, dynamic> product) {
    cartItems.add(product);
  }

  static void removeFromCart(String name) {
    cartItems.removeWhere((item) => item['name'] == name);
  }

  static List<Map<String, dynamic>> getCartItems() {
    return cartItems;
  }

  int cartTotalItems() {
    return cartItems.length;
  }
}
