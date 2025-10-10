import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/product_provider.dart';
import 'providers/cart_provider.dart';
import 'services/notification_service.dart';

import 'screens/home_screen.dart';
import 'screens/auth/sign_in_screen.dart';
import 'screens/auth/sign_up_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/product_list_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/manage_products_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TokoCahayaLkzApp());
}

class TokoCahayaLkzApp extends StatelessWidget {
  const TokoCahayaLkzApp({super.key});

  @override
  Widget build(BuildContext context) {
    final seed = const Color(0xFF60A5FA); // light blue 400
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()..seedMock()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        Provider(create: (_) => NotificationService()),
      ],
      child: MaterialApp(
        title: 'Toko Cahaya Lkz',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light),
          useMaterial3: true,
          fontFamily: 'Roboto',
        ),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (_) => const HomeScreen(),
          SignInScreen.routeName: (_) => const SignInScreen(),
          SignUpScreen.routeName: (_) => const SignUpScreen(),
          DashboardScreen.routeName: (_) => const DashboardScreen(),
          ProductListScreen.routeName: (_) => const ProductListScreen(),
          CartScreen.routeName: (_) => const CartScreen(),
          CheckoutScreen.routeName: (_) => const CheckoutScreen(),
          ManageProductsScreen.routeName: (_) => const ManageProductsScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == ProductDetailScreen.routeName) {
            final args = settings.arguments;
            if (args is String) {
              return MaterialPageRoute(
                builder: (_) => ProductDetailScreen(productId: args),
              );
            }
          }
          return null;
        },
      ),
    );
  }
}
