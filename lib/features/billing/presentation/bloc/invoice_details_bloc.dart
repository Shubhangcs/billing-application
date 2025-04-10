import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:new_billing/core/constants/urls.dart';

part 'invoice_details_event.dart';
part 'invoice_details_state.dart';

class InvoiceDetailsBloc
    extends Bloc<InvoiceDetailsEvent, InvoiceDetailsState> {
  InvoiceDetailsBloc() : super(InvoiceDetailsInitial()) {
    on<InitialInvoiceDetailsFetchEvent>(_fetchDetails);
  }

  Future<void> _fetchDetails(InitialInvoiceDetailsFetchEvent event,
      Emitter<InvoiceDetailsState> emit) async {
    emit(InvoiceDetailsLoadingState());
    try {
      final box = await Hive.openBox("authtoken");
      final details = JwtDecoder.decode(box.get("token"));
      final userId = details["user_id"];
      box.close();
      final jsonResponseRecivers = await http.get(
        Uri.parse("${AppUrls.getReceivers}/$userId"),
        headers: {"Content-Type": "application/json"},
      );
      final jsonResponseConsignee = await http.get(
        Uri.parse("${AppUrls.getConsignees}/$userId"),
        headers: {"Content-Type": "application/json"},
      );
      final reciverResponse = jsonDecode(jsonResponseRecivers.body);
      final consigneeResponse = jsonDecode(jsonResponseConsignee.body);

      if(reciverResponse == null || reciverResponse["reciver_details"] == null || consigneeResponse == null || consigneeResponse["consignee_details"] == null){
        emit(InitialInvoiceDetailsFetchFailureState(message: "No Customer or Shipper is Added."));
      }

      List<Map<String, dynamic>> receiverDetails =
          List<Map<String, dynamic>>.from(reciverResponse["receiver_details"]);
      List<Map<String, dynamic>> consigneeDetails =
          List<Map<String, dynamic>>.from(
              consigneeResponse["consignee_details"]);
              print(receiverDetails);

      if (jsonResponseConsignee.statusCode != 200 ||
          jsonResponseRecivers.statusCode != 200) {
        emit(InitialInvoiceDetailsFetchFailureState(
            message: "Unable to fetch the data."));
        return;
      }

      emit(
        InitialInvoiceDetailsFetchSuccessState(
          customers:  receiverDetails,
          shippers: consigneeDetails,
        ),
      );
    } catch (e) {
      print(e);
      emit(
        InitialInvoiceDetailsFetchFailureState(
          message: "An Exception Occured.",
        ),
      );
    }
  }
}
