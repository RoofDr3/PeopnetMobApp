import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peopnet/features/auth/view/pages/accountpage.dart';
import 'package:peopnet/features/auth/view/pages/dedicatedpage.dart';
import 'package:peopnet/features/auth/view/pages/detailssubservicepage.dart';
import 'package:peopnet/features/auth/view/pages/notifpage.dart';
import 'package:peopnet/features/auth/view/pages/retailpage.dart';
import 'package:peopnet/features/auth/view/pages/sohopage.dart';

import 'features/auth/view/pages/loginpage.dart';
import 'features/auth/view/pages/registerpage.dart';
import 'features/auth/view/pages/homepage.dart';
import 'features/auth/view/pages/cartpage.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peopnet Serve',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const Loginpage(),
        '/register': (context) => const Registerpage(),
        '/home': (context) => const HomePage(),
        '/account': (context) => const Accountpage(),
        '/cart': (context) => const CartPage(),
        '/retail': (context) => const RetailPage(),
        '/soho': (context) => const Sohopage(),
        '/dedicated': (context) => const Dedicatedpage(),
        '/detailservice': (context) => const DetailService(),
        // Tambahkan routes lain jika ada halaman baru
      },
    );
  }
}
