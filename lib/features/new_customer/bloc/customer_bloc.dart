import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:new_billing/core/constants/urls.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc() : super(CustomerInitial()) {
    on<AddCustomerEvent>(_addCustomer);
  }

  Future<void> _addCustomer(
      AddCustomerEvent event, Emitter<CustomerState> emit) async {
    emit(CustomerLoadingState());
    try {
      final box = await Hive.openBox("authtoken");
      final ids = JwtDecoder.decode(box.get("token"));
      box.close();
      final requestBody = jsonEncode({
        "receiver_name": event.customerName,
        "receiver_address": event.customerAddress,
        "receiver_gstin": event.customerGSTIN,
        "receiver_state": event.customerState,
        "receiver_state_code": event.customerStateCode,
        "user_id": ids["user_id"],
        "receiver_phone_number": event.customerPhoneNumber,
      });
      final jsonResponse = await http.post(
        Uri.parse(AppUrls.addCustomer),
        body: requestBody,
        headers: {"Content-Type": "application/json"},
      );
      final response = jsonDecode(jsonResponse.body);
      if(jsonResponse.statusCode != 200){
        emit(AddCustomerFailedState(message: response["message"]));
        return;
      }
      print(response);
      emit(AddCustomerSuccessState(message: response["message"]));
    } catch (e) {
      emit(AddCustomerFailedState(message: "An Exception Occured."));
    }
  }
}
