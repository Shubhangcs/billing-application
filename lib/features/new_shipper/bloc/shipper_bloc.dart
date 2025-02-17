import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:new_billing/core/constants/urls.dart';

part 'shipper_event.dart';
part 'shipper_state.dart';

class ShipperBloc extends Bloc<ShipperEvent, ShipperState> {
  ShipperBloc() : super(ShipperInitial()) {
    on<AddShipperEvent>(_addShipper);
  }

  Future<void> _addShipper(AddShipperEvent event, Emitter<ShipperState> emit) async {
    emit(ShipperLoadingState());
    if(event.shipperAddress.isEmpty || event.shipperGSTIN.isEmpty || event.shipperName.isEmpty || event.shipperPhoneNumber.isEmpty || event.shipperState.isEmpty || event.shipperStateCode.isEmpty){
      emit(AddShipperFailedState(message: "Enter the Required Credentils."));
    }
    try {
      final box = await Hive.openBox("authtoken");
      final userId = JwtDecoder.decode(box.get("token"));
      box.close();
      final requestBody = jsonEncode({
      "consignee_name": event.shipperName,
      "consignee_address": event.shipperAddress,
      "consignee_gstin": event.shipperGSTIN,
      "consignee_phone_number": event.shipperPhoneNumber,
      "consignee_state": event.shipperState,
      "consignee_state_code": event.shipperStateCode,
      "user_id": userId["user_id"],
    });
      final jsonResponse = await http.post(
        Uri.parse(AppUrls.addShipper),
        body: requestBody,
        headers: {"Content-Type": "application/json"},
      );
      final response = jsonDecode(jsonResponse.body);
      if(jsonResponse.statusCode != 200){
        emit(AddShipperFailedState(message: response["message"]));
        return;
      }
      emit(AddShipperSuccessState(message: response["message"]));
    } catch (e) {
      emit(AddShipperFailedState(message: "An Exception Occured."));
    }
  }
}
