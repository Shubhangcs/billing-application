import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:new_billing/core/constants/urls.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    on<FetchProductsEvent>(_fetchProductsEvent);
    on<AddProductEvent>(_addProducts);
  }

  Future<void> _addProducts(
      AddProductEvent event, Emitter<ProductsState> emit) async {
    emit(FetchProductLoadingState());
    try {
      final box = await Hive.openBox("invoice");
      final id = box.get("invoice_id");
      box.close();
      final requestBody = jsonEncode({
        "product_name": event.productName,
        "product_hsn": event.productHsn,
        "product_qty": event.productQty,
        "product_unit": event.productUnit,
        "product_rate": event.productRate,
        "invoice_id": id,
      });
      final jsonResponse = await http.post(
        Uri.parse(AppUrls.addProducts),
        body: requestBody,
        headers: {"Content-Type": "application/json"},
      );
      final response = jsonDecode(jsonResponse.body);
      if(jsonResponse.statusCode != 200){
        emit(AddProductsFailedState(message: response["message"]));
        return;
      }
      emit(AddProductsSuccessState(message: response["message"]));
    } catch (e) {
      emit(AddProductsFailedState(message: "An Exceprion Occured."));
    }
  }

  Future<void> _fetchProductsEvent(
      FetchProductsEvent event, Emitter<ProductsState> emit) async {
    try {
      final box = await Hive.openBox("invoice");
      final invoiceId = box.get("invoice_id");
      box.close();
      final jsonResponse = await http.get(
        Uri.parse("${AppUrls.getProducts}/$invoiceId"),
        headers: {"Content-Type": "application/json"},
      );
      final response = jsonDecode(jsonResponse.body);
      if (jsonResponse.statusCode != 200) {
        emit(FetchProductsFailureState(message: response["message"]));
        return;
      }
      if(response["receiver_details"] == null){
        emit(FetchProductSuccessState(products: []));
        return;
      }
      final List<Map<String, dynamic>> products =
          List<Map<String, dynamic>>.from(response["receiver_details"]);
      emit(FetchProductSuccessState(products: products));
    } catch (e) {
      emit(FetchProductsFailureState(message: "An Exception Occured."));
    }
  }
}
