import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_billing/core/common/widgets/app_bar.dart';
import 'package:new_billing/core/common/widgets/elevated_button.dart';
import 'package:new_billing/core/themes/colors.dart';
import 'package:new_billing/core/common/widgets/text_field.dart';
import 'package:new_billing/features/authentication/widgets/styled_icon.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().build(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StyledIcon(
                icon: Icons.lock,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Login",
                style: GoogleFonts.poppins(
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              CustomTextField(
                labelText: "Email",
                controller: _emailController,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                labelText: "Password",
                controller: _passwordController,
                obscureText: true,
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment(1, 0),
                child: Text(
                  "Forgot Password?",
                  style: GoogleFonts.poppins(
                    color: AppColors.blue,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomElevatedButton(
                buttonText: "Login",
                onPressed: (){
                  // TODO: What Happens
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.poppins(
                      color: AppColors.black,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 3,),
                  Text(
                    "Register",
                    style: GoogleFonts.poppins(
                      color: AppColors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
