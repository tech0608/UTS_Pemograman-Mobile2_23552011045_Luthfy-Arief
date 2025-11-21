import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';

// CartState to hold cart items with quantities
class CartState {
  final Map<String, dynamic>
  cartItems; // Map of product id to {product, quantity}

  CartState({required this.cartItems});

  CartState copyWith({Map<String, dynamic>? cartItems}) {
    return CartState(cartItems: cartItems ?? this.cartItems);
  }
}

// CartCubit to manage cart state
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(cartItems: {}));

  // Add product to cart
  void addToCart(ProductModel product) {
    final updatedCartItems = Map<String, dynamic>.from(state.cartItems);

    if (updatedCartItems.containsKey(product.id)) {
      // If product already exists, increment quantity
      updatedCartItems[product.id]['quantity']++;
    } else {
      // If new product, add with quantity 1
      updatedCartItems[product.id] = {'product': product, 'quantity': 1};
    }

    emit(state.copyWith(cartItems: updatedCartItems));
  }

  // Remove product from cart
  void removeFromCart(ProductModel product) {
    final updatedCartItems = Map<String, dynamic>.from(state.cartItems);
    updatedCartItems.remove(product.id);
    emit(state.copyWith(cartItems: updatedCartItems));
  }

  // Update quantity of product in cart
  void updateQuantity(ProductModel product, int quantity) {
    final updatedCartItems = Map<String, dynamic>.from(state.cartItems);

    if (quantity <= 0) {
      updatedCartItems.remove(product.id);
    } else {
      if (updatedCartItems.containsKey(product.id)) {
        updatedCartItems[product.id]['quantity'] = quantity;
      }
    }

    emit(state.copyWith(cartItems: updatedCartItems));
  }

  // Get total number of items in cart
  int getTotalItems() {
    int total = 0;
    for (var item in state.cartItems.values) {
      total += item['quantity'] as int;
    }
    return total;
  }

  // Get total price of items in cart
  int getTotalPrice() {
    int total = 0;
    for (var item in state.cartItems.values) {
      final product = item['product'] as ProductModel;
      final quantity = item['quantity'] as int;
      total += product.price * quantity;
    }
    return total;
  }

  // Clear all items from cart
  void clearCart() {
    emit(state.copyWith(cartItems: {}));
  }

  // Get all cart items as list
  List<Map<String, dynamic>> getCartItems() {
    return state.cartItems.values.cast<Map<String, dynamic>>().toList();
  }

  // Check if product is in cart
  bool isInCart(ProductModel product) {
    return state.cartItems.containsKey(product.id);
  }

  // Get quantity of specific product in cart
  int getProductQuantity(ProductModel product) {
    if (state.cartItems.containsKey(product.id)) {
      return state.cartItems[product.id]['quantity'] as int;
    }
    return 0;
  }
}
