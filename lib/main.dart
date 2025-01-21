import 'package:flutter/material.dart';
import 'package:new_billing/core/routes/generated_routes.dart';
import 'package:new_billing/core/themes/app_theme.dart';

void main() {
  runApp(const BillingApp());
}

class BillingApp extends StatelessWidget {
  const BillingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Routes.onGenerate,
      initialRoute: "/billing",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
