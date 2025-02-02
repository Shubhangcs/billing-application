part of 'history_bloc.dart';

@immutable
sealed class HistoryState {}

final class HistoryInitial extends HistoryState {}

final class FetchInvoicesLoadingState extends HistoryState{}

final class FetchInvoiceHistorySuccessState extends HistoryState{
  final List<Map<String , dynamic>> ? invoices;
  FetchInvoiceHistorySuccessState({required this.invoices});
}

final class FetchInvoiceHistoryFailedState extends HistoryState{
  final String message;
  FetchInvoiceHistoryFailedState({required this.message});
}