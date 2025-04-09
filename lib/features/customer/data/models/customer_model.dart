import 'package:new_billing/features/customer/domain/entities/customer_entity.dart';

class CustomerModel extends CustomerEntity {
  CustomerModel({
    required super.customerId,
    required super.customerName,
    required super.customerAddress,
    required super.customerGstNumber,
    required super.customerState,
    required super.customerStateCode,
    required super.userId,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      customerId: json["reciver_id"],
      customerName: json["reciver_name"],
      customerAddress: json["reciver_address"],
      customerGstNumber: json["reciver_gstin"],
      customerState: json["reciver_state"],
      customerStateCode: json["reciver_state_code"],
      userId: json["user_id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "reciver_name": customerName,
      "reciver_address": customerAddress,
      "reciver_gstin": customerGstNumber,
      "reciver_state": customerState,
      "reciver_state_code": customerStateCode,
      "user_id": userId,
    };
  }
}
