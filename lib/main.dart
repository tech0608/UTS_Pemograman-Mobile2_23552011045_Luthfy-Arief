import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/cart_cubit.dart';
import 'pages/cart_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: MaterialApp(
        title: 'Zero Latency - Gaming Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Futuristic Gaming Color Palette
          colorScheme: ColorScheme.dark(
            primary: const Color(0xFF00FF41),
            secondary: const Color(0xFFFF006E),
            tertiary: const Color(0xFF00D9FF),
            surface: const Color(0xFF0A0E27),
            background: const Color(0xFF050816),
            onPrimary: const Color(0xFF000000),
            onSecondary: const Color(0xFF000000),
            onSurface: const Color(0xFF00FF41),
            onBackground: const Color(0xFFE0E0E0),
            error: const Color(0xFFFF3D3D),
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFF050816),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF0A0E27),
            foregroundColor: Color(0xFF00FF41),
            elevation: 4,
            shadowColor: Color(0xFF00FF41),
          ),
          cardTheme: CardThemeData(
            color: const Color(0xFF0A0E27),
            elevation: 8,
            shadowColor: const Color(0xFF00FF41).withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: const Color(0xFF00FF41).withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00FF41),
              foregroundColor: const Color(0xFF000000),
              elevation: 8,
              shadowColor: const Color(0xFF00FF41).withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          iconTheme: const IconThemeData(color: Color(0xFF00FF41)),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              color: Color(0xFF00FF41),
              fontWeight: FontWeight.bold,
              fontSize: 32,
              shadows: [Shadow(color: Color(0xFF00FF41), blurRadius: 10)],
            ),
            headlineMedium: TextStyle(
              color: Color(0xFF00FF41),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            bodyLarge: TextStyle(color: Color(0xFFE0E0E0), fontSize: 16),
            bodyMedium: TextStyle(color: Color(0xFFB0B0B0), fontSize: 14),
          ),
          chipTheme: ChipThemeData(
            backgroundColor: const Color(0xFF0A0E27),
            selectedColor: const Color(0xFF00FF41),
            deleteIconColor: const Color(0xFFFF006E),
            labelStyle: const TextStyle(color: Color(0xFF00FF41)),
            side: BorderSide(color: const Color(0xFF00FF41).withOpacity(0.3)),
          ),
        ),
        home: const CartHomePage(),
      ),
    );
  }
}
