import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:new_billing/core/constants/urls.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginEvent>(_authLogin);
    on<AuthRegisterEvent>(_authRegister);
  }

  Future<void> _authLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(AuthFailureState(message: "Enter Credentials in the Fields."));
      return;
    }
    final requestBody = jsonEncode({
      "user_email": event.email,
      "user_password": event.password,
    });

    try {
      final jsonResponse = await http.post(
        Uri.parse(AppUrls.login),
        body: requestBody,
        headers: {"Content-Type": "application/json"},
      );
      final response = jsonDecode(jsonResponse.body);
      if (jsonResponse.statusCode != 200) {
        emit(AuthFailureState(message: response["message"]));
        return;
      }
      final box = await Hive.openBox("authtoken");
      box.put("token", response["token"]);
      box.close();
      emit(AuthSuccessState(message: "Login Successful."));
    } catch (e) {
      emit(AuthFailureState(message: "An Exception Occured."));
    }
  }

  Future<void> _authRegister(AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    if (event.userName.isEmpty ||
        event.email.isEmpty ||
        event.address.isEmpty ||
        event.gstNo.isEmpty ||
        event.panNo.isEmpty ||
        event.password.isEmpty ||
        event.phoneNumber.isEmpty) {
      emit(AuthFailureState(message: "Enter Credentials in the Fields."));
    }
    final requestBody = jsonEncode({
      "user_name": event.userName,
      "user_email": event.email,
      "user_password": event.password,
      "user_address": event.address,
      "user_phone": event.phoneNumber,
      "user_gstin": event.gstNo,
      "user_pan": event.panNo,
    });
    try {
      final jsonResponse = await http.post(
      Uri.parse(AppUrls.register),
      body: requestBody,
      headers: {"Content-Type": "application/json"},
    );
    final response = jsonDecode(jsonResponse.body);
    if(jsonResponse.statusCode != 200){
      emit(AuthFailureState(message: response["message"]));
      return;
    }
    final box = await Hive.openBox("authtoken");
    box.put("token", response["token"]);
    box.close();
    emit(AuthSuccessState(message: "Registration Successful."));
    } catch (e) {
      emit(AuthFailureState(message: "An Exception Occured."));
    }
  }
}
