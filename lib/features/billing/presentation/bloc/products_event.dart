part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}


final class FetchProductsEvent extends ProductsEvent{}


final class AddProductEvent extends ProductsEvent{
  final String productName;
  final String productHsn;
  final String productQty;
  final String productUnit;
  final String productRate;
  AddProductEvent({required this.productName , required this.productHsn , required this.productQty , required this.productRate , required this.productUnit});
}
