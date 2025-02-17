import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_billing/features/authentication/bloc/auth_bloc.dart';
import 'package:new_billing/features/authentication/pages/login.dart';
import 'package:new_billing/features/authentication/pages/register.dart';
import 'package:new_billing/features/billing/bloc/invoice_bloc.dart';
import 'package:new_billing/features/billing/bloc/invoice_details_bloc.dart';
import 'package:new_billing/features/billing/bloc/products_bloc.dart';
import 'package:new_billing/features/billing/pages/billing_page.dart';
import 'package:new_billing/features/billing/pages/product_page.dart';
import 'package:new_billing/features/history/bloc/history_bloc.dart';
import 'package:new_billing/features/history/pages/history_page.dart';
import 'package:new_billing/features/home/pages/home.dart';
import 'package:new_billing/features/new_customer/bloc/customer_bloc.dart';
import 'package:new_billing/features/new_customer/pages/customer_page.dart';
import 'package:new_billing/features/new_shipper/bloc/shipper_bloc.dart';
import 'package:new_billing/features/new_shipper/pages/shipper_page.dart';

class Routes {
  static Route? onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case "/login":
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthBloc(),
            child: LoginPage(),
          ),
        );

      case "/register":
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthBloc(),
            child: RegisterPage(),
          ),
        );

      case "/home":
        return MaterialPageRoute(
          builder: (context) => HomePage(),
        );

      case "/billing":
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => InvoiceBloc(),
              ),
              BlocProvider(
                create: (context) => InvoiceDetailsBloc(),
              ),
            ],
            child: BillingPage(),
          ),
        );

      case "/products":
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ProductsBloc(),
            child: ProductPage(),
          ),
        );

      case "/history":
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => HistoryBloc(),
            child: HistoryPage(),
          ),
        );

      case "/customer":
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => CustomerBloc(),
            child: CustomerPage(),
          ),
        );

      case "/shipper":
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ShipperBloc(),
            child: ShipperPage(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(),
        );
    }
  }
}
