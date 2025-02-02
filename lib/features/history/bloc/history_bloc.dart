import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:new_billing/core/constants/urls.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial()) {
    on<FetchInvoiceHistoryEvent>(_fetchInvoices);
  }

  Future<void> _fetchInvoices(
      FetchInvoiceHistoryEvent event, Emitter<HistoryState> emit) async {
    emit(FetchInvoicesLoadingState());
    try {
      final box = await Hive.openBox("authtoken");
      final tokenData = JwtDecoder.decode(box.get("token"));
      box.close();
      final String userId = tokenData["user_id"];
      final jsonResponse = await http.get(
        Uri.parse("${AppUrls.fetchInvoices}/$userId"),
        headers: {"Content-Type": "application/json"},
      );
      final response = jsonDecode(jsonResponse.body);
      if(jsonResponse.statusCode != 200){
        emit(FetchInvoiceHistoryFailedState(message: response["message"]));
        return;
      }
      emit(FetchInvoiceHistorySuccessState(invoices: response["invoices"]));
    } catch (e) {
      emit(FetchInvoiceHistoryFailedState(message: "An Exception Occured."));
    }
  }
}
