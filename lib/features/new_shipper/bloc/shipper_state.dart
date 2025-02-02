part of 'shipper_bloc.dart';

@immutable
sealed class ShipperState {}

final class ShipperInitial extends ShipperState {}


final class ShipperLoadingState extends ShipperState{}

final class AddShipperSuccessState extends ShipperState{
  final String message;
  AddShipperSuccessState({required this.message});
}


final class AddShipperFailedState extends ShipperState{
  final String message;
  AddShipperFailedState({required this.message});
}