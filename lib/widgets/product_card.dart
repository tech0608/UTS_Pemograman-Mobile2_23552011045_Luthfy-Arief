import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';
import '../blocs/cart_cubit.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cartCubit = context.read<CartCubit>();
        final isInCart = cartCubit.isInCart(product);
        final quantity = cartCubit.getProductQuantity(product);

        return Card(
          elevation: 8,
          margin: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: const Color(0xFF00FF41).withOpacity(0.3),
              width: 1,
            ),
          ),
          color: const Color(0xFF050816),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF0A0E27).withOpacity(0.8),
                        const Color(0xFF050816),
                      ],
                    ),
                    border: Border.all(
                      color: const Color(0xFF00FF41).withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: product.image.isNotEmpty
                      ? ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
                            product.image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                  color: const Color(
                                    0xFF00FF41,
                                  ).withOpacity(0.3),
                                ),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Icon(
                            Icons.videogame_asset,
                            size: 50,
                            color: const Color(0xFF00FF41).withOpacity(0.3),
                          ),
                        ),
                ),
              ),
              // Product Details
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Product Name
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00FF41),
                          shadows: [
                            Shadow(color: Color(0xFF00FF41), blurRadius: 4),
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      // Product Price
                      Text(
                        'Rp ${product.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF00D9FF),
                          fontWeight: FontWeight.w600,
                          shadows: [
                            Shadow(color: Color(0xFF00D9FF), blurRadius: 3),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Add to Cart Button or Quantity Controls
                      if (!isInCart)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              cartCubit.addToCart(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${product.name} added to cart',
                                  ),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00FF41),
                              foregroundColor: const Color(0xFF050816),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              elevation: 4,
                              shadowColor: const Color(
                                0xFF00FF41,
                              ).withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Tambah',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      else
                        Row(
                          children: [
                            // Decrease quantity button
                            IconButton(
                              onPressed: () {
                                if (quantity > 1) {
                                  cartCubit.updateQuantity(
                                    product,
                                    quantity - 1,
                                  );
                                } else {
                                  cartCubit.removeFromCart(product);
                                }
                              },
                              icon: const Icon(Icons.remove),
                              style: IconButton.styleFrom(
                                backgroundColor: const Color(0xFF0A0E27),
                                foregroundColor: const Color(0xFFFF006E),
                                side: const BorderSide(
                                  color: Color(0xFFFF006E),
                                  width: 1,
                                ),
                              ),
                            ),
                            // Quantity display
                            Expanded(
                              child: Text(
                                quantity.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF00FF41),
                                  shadows: [
                                    Shadow(
                                      color: Color(0xFF00FF41),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Increase quantity button
                            IconButton(
                              onPressed: () {
                                cartCubit.updateQuantity(product, quantity + 1);
                              },
                              icon: const Icon(Icons.add),
                              style: IconButton.styleFrom(
                                backgroundColor: const Color(0xFF00FF41),
                                foregroundColor: const Color(0xFF050816),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
