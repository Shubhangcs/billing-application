import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_billing/core/common/widgets/app_bar.dart';
import 'package:new_billing/core/common/widgets/custom_snackbar.dart';
import 'package:new_billing/core/common/widgets/elevated_button.dart';
import 'package:new_billing/core/common/widgets/text_field.dart';
import 'package:new_billing/core/themes/colors.dart';
import 'package:new_billing/features/authentication/bloc/auth_bloc.dart';
import 'package:new_billing/features/authentication/widgets/styled_icon.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _gstController.dispose();
    _panController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is AuthSuccessState){
          Navigator.pushReplacementNamed(context, "/home");
          return;
        }
        if(state is AuthFailureState){
          CustomSnackbar.snackbarShow(context, state.message);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar().build(context),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StyledIcon(
                    icon: Icons.person,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Register",
                    style: GoogleFonts.poppins(
                      color: AppColors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    showWordCount: false,
                    maxLength: 20,
                    labelText: "Username",
                    controller: _userNameController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    maxLength: 10,
                    labelText: "Phone",
                    controller: _phoneNumberController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    maxLength: 46,
                    labelText: "Address",
                    controller: _addressController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    maxLength: 15,
                    labelText: "GSTIN",
                    controller: _gstController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    maxLength: 10,
                    labelText: "PAN",
                    controller: _panController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    showWordCount: false,
                    maxLength: 50,
                    labelText: "Email",
                    controller: _emailController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    showWordCount: false,
                    maxLength: 20,
                    labelText: "Password",
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return CustomElevatedButton(
                        isLoading: state is AuthLoadingState,
                        buttonText: "Register",
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                AuthRegisterEvent(
                                  userName: _userNameController.text,
                                  phoneNumber: _phoneNumberController.text,
                                  address: _addressController.text,
                                  gstNo: _gstController.text,
                                  panNo: _panController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: GoogleFonts.poppins(
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "Login",
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
        ),
      ),
    );
  }
}
