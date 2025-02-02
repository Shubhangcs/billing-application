part of 'invoice_bloc.dart';

@immutable
sealed class InvoiceState {}

final class InvoiceInitial extends InvoiceState {}


final class SubmitInvoiceSuccessState extends InvoiceState{
  final String message;
  SubmitInvoiceSuccessState({required this.message});
}

final class SubmitInvoiceFailedState extends InvoiceState{
  final String message;
  SubmitInvoiceFailedState({required this.message});
}

final class SubmitInvoiceLoadingState extends InvoiceState{}

