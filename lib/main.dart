import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_billing/core/routes/generated_routes.dart';
import 'package:new_billing/core/themes/app_theme.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hivePath = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(hivePath.path);
  final box = await Hive.openBox("authtoken");
  runApp(BillingApp(authToken: box.get("token"),),);
  await box.close();
}

class BillingApp extends StatelessWidget {
  final String? authToken;
  const BillingApp({super.key , required this.authToken});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Routes.onGenerate,
      initialRoute: authToken != null ? "/home":"/login",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
