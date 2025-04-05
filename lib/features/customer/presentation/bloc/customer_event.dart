part of 'customer_bloc.dart';

@immutable
sealed class CustomerEvent {}

final class AddCustomerEvent extends CustomerEvent {
  final String customerName;
  final String customerAddress;
  final String customerGSTIN;
  final String customerState;
  final String customerStateCode;
  final String customerPhoneNumber;
  AddCustomerEvent({
    required this.customerName,
    required this.customerAddress,
    required this.customerGSTIN,
    required this.customerPhoneNumber,
    required this.customerState,
    required this.customerStateCode,
  });
}
