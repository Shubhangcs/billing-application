part of 'customer_bloc.dart';

@immutable
sealed class CustomerState {}

final class CustomerInitial extends CustomerState {}

final class CustomerLoadingState extends CustomerState{}

final class AddCustomerSuccessState extends CustomerState{
  final String message;
  AddCustomerSuccessState({required this.message});
}

final class AddCustomerFailedState extends CustomerState{
  final String message;
  AddCustomerFailedState({required this.message});
}
