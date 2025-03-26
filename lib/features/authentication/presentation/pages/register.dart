import 'package:flutter/material.dart';
import 'package:new_billing/core/themes/colors.dart';
import 'package:new_billing/core/widgets/app_filled_button.dart';
import 'package:new_billing/core/widgets/app_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/register.jpg",
                  width: 340,
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment(-1, 0),
                  child: Text(
                    "Sign Up",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment(-1, 0),
                  child: Text(
                    "Create your Account to Start Billing.",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                AppTextField(
                  controller: _nameController,
                  hintText: "Username",
                  prefixIcon: Icons.person,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 20,
                ),
                AppTextField(
                  controller: _emailController,
                  hintText: "Email",
                  prefixIcon: Icons.alternate_email_rounded,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20,
                ),
                AppTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  prefixIcon: Icons.password_rounded,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 20,
                ),
                AppFilledButton(
                  onPressed: () {},
                  buttonText: "Sign Up",
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an Account?",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Text(
                "Login.",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.blue,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
