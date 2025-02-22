part of 'invoice_details_bloc.dart';

@immutable
sealed class InvoiceDetailsState {}

final class InvoiceDetailsInitial extends InvoiceDetailsState {}

final class InitialInvoiceDetailsFetchSuccessState extends InvoiceDetailsState {
  final List<Map<String , dynamic>> ? customers;
  final List<Map<String , dynamic>> shippers;
  InitialInvoiceDetailsFetchSuccessState({
    required this.customers,
    required this.shippers,
  });
}

final class InitialInvoiceDetailsFetchFailureState extends InvoiceDetailsState {
  final String message;
  InitialInvoiceDetailsFetchFailureState({required this.message});
}

final class InvoiceDetailsLoadingState extends InvoiceDetailsState{}