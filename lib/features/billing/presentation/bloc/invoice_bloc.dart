import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:new_billing/core/constants/urls.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  InvoiceBloc() : super(InvoiceInitial()) {
    on<SubmitInvoiceEvent>(_submitInvoice);
  }

    Future<void> _submitInvoice(SubmitInvoiceEvent event,
      Emitter<InvoiceState> emit) async {
        emit(SubmitInvoiceLoadingState());
    try {
      if(event.customerId.isEmpty || event.invoiceDateOfSupply.isEmpty || event.invoiceName.isEmpty || event.invoicePlaceOfSupply.isEmpty || event.invoiceReverseCharge.isEmpty || event.invoiceState.isEmpty || event.invoiceStateCode.isEmpty || event.shipperId.isEmpty){
        emit(SubmitInvoiceFailedState(message: "Enter the Required Credentials."));
      }
      final box = await Hive.openBox("authtoken");
      final details = JwtDecoder.decode(box.get("token"));
      final userId = details["user_id"];
      box.close();
      print(event.customerId);
      final requestBody = jsonEncode({
        "invoice_name": event.invoiceName,
        "invoice_reverse_charge": event.invoiceReverseCharge,
        "invoice_state": event.invoiceState,
        "invoice_state_code": event.invoiceStateCode,
        "invoice_challan_number": event.invoiceChallanNo ?? " ",
        "invoice_vehicle_number": event.invoiceVehicleNo ?? " ",
        "invoice_date_of_supply": event.invoiceDateOfSupply,
        "invoice_place_of_supply": event.invoicePlaceOfSupply,
        "user_id": userId,
        "receiver_id": event.customerId,
        "consignee_id": event.shipperId,
      });
      final jsonResponse = await http.post(
        Uri.parse(AppUrls.createInvoice),
        body: requestBody,
        headers: {"Content-Type": "application/json"},
      );
      final response = jsonDecode(jsonResponse.body);
      if (jsonResponse.statusCode != 200) {
        emit(SubmitInvoiceFailedState(message: response["message"]));
        return;
      }
      final invoiceBox = await Hive.openBox("invoice");
      invoiceBox.put("invoice_id", response["invoice_id"]);
      invoiceBox.close();
      emit(SubmitInvoiceSuccessState(message: "created successfully"));
    } catch (e) {
      emit(SubmitInvoiceFailedState(message: "An Exception Occured"));
    }
  }
}
