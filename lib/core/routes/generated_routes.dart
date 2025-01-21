import 'package:flutter/material.dart';
import 'package:new_billing/features/authentication/pages/login.dart';
import 'package:new_billing/features/authentication/pages/register.dart';
import 'package:new_billing/features/billing/pages/billing_page.dart';
import 'package:new_billing/features/home/pages/home.dart';

class Routes {
  static Route? onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case "/login":
        return MaterialPageRoute(
          builder: (context) => LoginPage(),
        );

      case "/register":
        return MaterialPageRoute(
          builder: (context) => RegisterPage(),
        );

      case "/home":
        return MaterialPageRoute(
          builder: (context) => HomePage(),
        );

      case "/billing":
        return MaterialPageRoute(
          builder: (context) => BillingPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(),
        );
    }
  }
}
