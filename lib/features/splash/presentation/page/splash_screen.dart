import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_billing/core/themes/colors.dart';
import 'package:new_billing/features/authentication/presentation/cubit/auto_login_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    BlocProvider.of<AutoLoginCubit>(context).autoLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AutoLoginCubit, AutoLoginState>(
      listener: (context, state) {
        if (state is AutoLoginSuccessState && state.token != null) {
          Navigator.pushReplacementNamed(context, "/home");
        } else {
          Navigator.pushReplacementNamed(context, "/login");
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/pay.png",
                width: 120,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Billsoft",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: AppColors.blue,
                      fontWeight: FontWeight.w300,
                    ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 25),
          child: Text(
            "Designed and Developed by Vithsutra",
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
