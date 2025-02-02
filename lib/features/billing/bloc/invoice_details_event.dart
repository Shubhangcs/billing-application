part of 'invoice_details_bloc.dart';

@immutable
sealed class InvoiceDetailsEvent {}

final class InitialInvoiceDetailsFetchEvent extends InvoiceDetailsEvent{}

final class SubmitInvoiceDetailsEvent extends InvoiceDetailsEvent{
  final String invoiceName;
  final String invoiceReverseCharge;
  final String invoiceState;
  final String invoiceStateCode;
  final String invoiceChallanNo;
  final String invoiceVehicleNo;
  final String invoiceDateOfSupply;
  final String invoicePlaceOfSupply;
  final String userId;
  final String customerId;
  final String shipperId;
  SubmitInvoiceDetailsEvent({
    required this.customerId,
    required this.invoiceChallanNo,
    required this.invoiceDateOfSupply,
    required this.invoiceName,
    required this.invoicePlaceOfSupply,
    required this.invoiceReverseCharge,
    required this.invoiceState,
    required this.invoiceStateCode,
    required this.invoiceVehicleNo,
    required this.shipperId,
    required this.userId,
  });
}
