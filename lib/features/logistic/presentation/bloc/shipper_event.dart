part of 'shipper_bloc.dart';

@immutable
sealed class ShipperEvent {}

final class AddShipperEvent extends ShipperEvent {
  final String shipperName;
  final String shipperAddress;
  final String shipperGSTIN;
  final String shipperPhoneNumber;
  final String shipperState;
  final String shipperStateCode;
  AddShipperEvent({
    required this.shipperName,
    required this.shipperAddress,
    required this.shipperGSTIN,
    required this.shipperPhoneNumber,
    required this.shipperState,
    required this.shipperStateCode,
  });
}
