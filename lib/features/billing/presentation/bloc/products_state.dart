part of 'products_bloc.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}


final class FetchProductLoadingState extends ProductsState{}

final class FetchProductSuccessState extends ProductsState{
  final List<Map<String , dynamic>> products;
  FetchProductSuccessState({required this.products});
}

final class FetchProductsFailureState extends ProductsState{
  final String message;
  FetchProductsFailureState({required this.message});
}

final class AddProductsSuccessState extends ProductsState{
  final String message;
  AddProductsSuccessState({required this.message});
}

final class AddProductsFailedState extends ProductsState{
  final String message;
  AddProductsFailedState({required this.message});
}
