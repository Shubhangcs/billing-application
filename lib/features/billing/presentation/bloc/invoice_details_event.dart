part of 'invoice_details_bloc.dart';

@immutable
sealed class InvoiceDetailsEvent {}

final class InitialInvoiceDetailsFetchEvent extends InvoiceDetailsEvent{}

