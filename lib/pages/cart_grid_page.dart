import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_cubit.dart';
import '../widgets/product_card.dart';
import '../models/product_model.dart';

class CartGridPage extends StatefulWidget {
  const CartGridPage({super.key});

  @override
  State<CartGridPage> createState() => _CartGridPageState();
}

class _CartGridPageState extends State<CartGridPage> {
  final List<ProductModel> products = [
    ProductModel(
      id: '1',
      name: 'Processor Intel i7-13700K',
      price: 6500000,
      image: 'https://images.unsplash.com/photo-1555617778-02518db17928?w=500',
    ),
    ProductModel(
      id: '2',
      name: 'GPU RTX 4070 Super',
      price: 9000000,
      image:
          'https://images.unsplash.com/photo-1591488320449-011701bb6704?w=500',
    ),
    ProductModel(
      id: '3',
      name: 'Motherboard ASUS ROG',
      price: 3500000,
      image:
          'https://images.unsplash.com/photo-1591488320449-011701bb6704?w=500',
    ),
    ProductModel(
      id: '4',
      name: 'RAM Corsair 32GB DDR5',
      price: 4200000,
      image: 'https://images.unsplash.com/photo-1562976540-1502c2145186?w=500',
    ),
    ProductModel(
      id: '5',
      name: 'SSD Samsung 1TB NVMe',
      price: 1800000,
      image:
          'https://images.unsplash.com/photo-1597872200969-2b65d56bd16b?w=500',
    ),
    ProductModel(
      id: '6',
      name: 'Power Supply 750W',
      price: 1500000,
      image:
          'https://images.unsplash.com/photo-1518709268805-4e9042af2176?w=500',
    ),
  ];

  String filterType = 'all'; // all, with_quantity, no_quantity

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grid View'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, cartState) {
          final filteredProducts = _getFilteredProducts(cartState);
          final totalItems = context.read<CartCubit>().getTotalItems();
          final totalPrice = context.read<CartCubit>().getTotalPrice();

          return Column(
            children: [
              // Filter Controls Section (Section C Bonus Features)
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Filter Buttons Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildFilterButton(
                            'all',
                            'Semua\\nProduk',
                            Icons.grid_view,
                            cartState,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildFilterButton(
                            'with_quantity',
                            'Ada di\\nKeranjang',
                            Icons.shopping_cart,
                            cartState,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildFilterButton(
                            'no_quantity',
                            'Kosong\\nKeranjang',
                            Icons.shopping_cart_outlined,
                            cartState,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Special Action Buttons Row (Section C Main Features)
                    Row(
                      children: [
                        Expanded(
                          child: _buildSpecialButton(
                            '×2',
                            'Gandakan\\nSemua',
                            Colors.green,
                            () => _doubleAllQuantities(context),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildSpecialButton(
                            '+1',
                            'Tambah\\nSemua',
                            Colors.blue,
                            () => _addAllToCart(context),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildSpecialButton(
                            '↺',
                            'Reset\\nKeranjang',
                            Colors.red,
                            () => _resetCart(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Real-time Total Info Bar
              if (totalItems > 0)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  color: Theme.of(
                    context,
                  ).colorScheme.primaryContainer.withOpacity(0.7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '📦 Total: $totalItems item${totalItems > 1 ? 's' : ''}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '💰 Rp ${_formatPrice(totalPrice)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),

              // Products Grid with Dynamic Content
              Expanded(
                child: filteredProducts.isEmpty
                    ? _buildEmptyState()
                    : GridView.builder(
                        padding: const EdgeInsets.all(12.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 12.0,
                              mainAxisSpacing: 12.0,
                            ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          return ProductCard(product: filteredProducts[index]);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<ProductModel> _getFilteredProducts(CartState cartState) {
    switch (filterType) {
      case 'with_quantity':
        return products
            .where(
              (product) =>
                  cartState.cartItems.containsKey(product.id) &&
                  (cartState.cartItems[product.id]?['quantity'] ?? 0) > 0,
            )
            .toList();
      case 'no_quantity':
        return products
            .where(
              (product) =>
                  !cartState.cartItems.containsKey(product.id) ||
                  (cartState.cartItems[product.id]?['quantity'] ?? 0) == 0,
            )
            .toList();
      default:
        return products;
    }
  }

  Widget _buildFilterButton(
    String type,
    String label,
    IconData icon,
    CartState cartState,
  ) {
    final isSelected = filterType == type;
    int count = 0;

    switch (type) {
      case 'with_quantity':
        count = products
            .where(
              (product) =>
                  cartState.cartItems.containsKey(product.id) &&
                  (cartState.cartItems[product.id]?['quantity'] ?? 0) > 0,
            )
            .length;
        break;
      case 'no_quantity':
        count = products
            .where(
              (product) =>
                  !cartState.cartItems.containsKey(product.id) ||
                  (cartState.cartItems[product.id]?['quantity'] ?? 0) == 0,
            )
            .length;
        break;
      default:
        count = products.length;
    }

    return ElevatedButton(
      onPressed: () {
        setState(() {
          filterType = type;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
        foregroundColor: isSelected
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.onSurface,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        elevation: isSelected ? 3 : 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.white.withOpacity(0.8)
                  : Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialButton(
    String symbol,
    String label,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.1),
        foregroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        side: BorderSide(color: color.withOpacity(0.4), width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 2,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            symbol,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    IconData icon;
    String message;
    String subMessage;

    switch (filterType) {
      case 'with_quantity':
        icon = Icons.shopping_cart_outlined;
        message = 'Keranjang Kosong';
        subMessage = 'Tidak ada produk di keranjang';
        break;
      case 'no_quantity':
        icon = Icons.add_shopping_cart;
        message = 'Semua Sudah di Keranjang';
        subMessage = 'Semua produk sudah ditambahkan';
        break;
      default:
        icon = Icons.grid_view;
        message = 'Tidak Ada Produk';
        subMessage = 'Produk belum tersedia';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.grey.withOpacity(0.7)),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subMessage,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Section C Bonus Feature Methods
  void _doubleAllQuantities(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final currentCart = cartCubit.state;
    int affectedProducts = 0;

    // Double quantity for each item already in cart
    for (final product in products) {
      if (currentCart.cartItems.containsKey(product.id)) {
        final currentQuantity =
            currentCart.cartItems[product.id]?['quantity'] ?? 0;
        if (currentQuantity > 0) {
          cartCubit.updateQuantity(product, currentQuantity * 2);
          affectedProducts++;
        }
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          affectedProducts > 0
              ? '🔥 $affectedProducts produk dikali dua!'
              : '⚠️ Tidak ada produk untuk digandakan',
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: affectedProducts > 0 ? Colors.green : Colors.orange,
      ),
    );
  }

  void _addAllToCart(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    // Add 1 quantity for each product
    for (final product in products) {
      cartCubit.addToCart(product);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '✅ Semua ${products.length} produk ditambahkan ke keranjang!',
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _resetCart(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('🗑️ Konfirmasi Reset'),
          content: const Text(
            'Apakah Anda yakin ingin mengosongkan seluruh keranjang belanja?',
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final cartCubit = context.read<CartCubit>();
                cartCubit.clearCart();

                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('🗑️ Keranjang berhasil dikosongkan!'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );
  }
}
