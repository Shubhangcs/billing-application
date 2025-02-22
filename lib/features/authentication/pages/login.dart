import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_billing/core/common/widgets/app_bar.dart';
import 'package:new_billing/core/common/widgets/custom_snackbar.dart';
import 'package:new_billing/core/common/widgets/elevated_button.dart';
import 'package:new_billing/core/themes/colors.dart';
import 'package:new_billing/core/common/widgets/text_field.dart';
import 'package:new_billing/features/authentication/bloc/auth_bloc.dart';
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          Navigator.pushReplacementNamed(context, "/home");
          return;
        }
        if (state is AuthFailureState) {
          CustomSnackbar.snackbarShow(context, state.message);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar().build(context),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                StyledIcon(
                                  icon: Icons.lock,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Login",
                                  style: GoogleFonts.poppins(
                                    color: AppColors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 40),
                                CustomTextField(
                                  showWordCount: false,
                                  labelText: "Email",
                                  controller: _emailController,
                                  maxLength: 50,
                                ),
                                SizedBox(height: 20),
                                CustomTextField(
                                  showWordCount: false,
                                  maxLength: 20,
                                  labelText: "Password",
                                  controller: _passwordController,
                                  obscureText: true,
                                ),
                                SizedBox(height: 20),
                                BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    return CustomElevatedButton(
                                      isLoading: state is AuthLoadingState,
                                      buttonText: "Login",
                                      onPressed: () {
                                        context.read<AuthBloc>().add(
                                              AuthLoginEvent(
                                                email: _emailController.text,
                                                password:
                                                    _passwordController.text,
                                              ),
                                            );
                                      },
                                    );
                                  },
                                ),
                                SizedBox(height: 20),
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
                                    SizedBox(width: 3),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                            context, "/register");
                                      },
                                      child: Text(
                                        "Register",
                                        style: GoogleFonts.poppins(
                                          color: AppColors.blue,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
