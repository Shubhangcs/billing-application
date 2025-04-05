import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_billing/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:new_billing/features/authentication/presentation/pages/login.dart';
import 'package:new_billing/features/authentication/presentation/pages/register.dart';
import 'package:new_billing/features/billing/bloc/invoice_bloc.dart';
import 'package:new_billing/features/billing/bloc/invoice_details_bloc.dart';
import 'package:new_billing/features/billing/bloc/products_bloc.dart';
import 'package:new_billing/features/billing/pages/billing_page.dart';
import 'package:new_billing/features/billing/pages/product_page.dart';
import 'package:new_billing/features/history/presentation/bloc/history_bloc.dart';
import 'package:new_billing/features/history/presentation/cubit/delete_invoice_cubit.dart';
import 'package:new_billing/features/history/presentation/cubit/payment_status_updater_cubit.dart';
import 'package:new_billing/features/history/presentation/pages/history_page.dart';
import 'package:new_billing/features/home/pages/home.dart';
import 'package:new_billing/features/new_customer/bloc/customer_bloc.dart';
import 'package:new_billing/features/new_customer/pages/customer_page.dart';
import 'package:new_billing/features/new_shipper/bloc/shipper_bloc.dart';
import 'package:new_billing/features/new_shipper/pages/shipper_page.dart';
import 'package:new_billing/init_dependencies.dart';

class Routes {
  static Route? onGenerate(RouteSettings settings) {
    const String login = "/login";
    const String register = "/register";
    const String history = "/history";
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => serviceLocator<AuthBloc>(),
            child: LoginPage(),
          ),
        );

      case register:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => serviceLocator<AuthBloc>(),
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

      case history:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => serviceLocator<HistoryBloc>(),
              ),
              BlocProvider(
                create: (context) => serviceLocator<DeleteInvoiceCubit>(),
              ),
              BlocProvider(
                create: (context) =>
                    serviceLocator<PaymentStatusUpdaterCubit>(),
              ),
            ],
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
    }
  }
}
