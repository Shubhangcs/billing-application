part of 'invoice_bloc.dart';

@immutable
sealed class InvoiceEvent {}


final class SubmitInvoiceEvent extends InvoiceEvent{
  final String invoiceName;
  final String invoiceReverseCharge;
  final String invoiceState;
  final String invoiceStateCode;
  final String invoiceChallanNo;
  final String invoiceVehicleNo;
  final String invoiceDateOfSupply;
  final String invoicePlaceOfSupply;
  final String customerId;
  final String shipperId;
  SubmitInvoiceEvent({
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
  });
}
