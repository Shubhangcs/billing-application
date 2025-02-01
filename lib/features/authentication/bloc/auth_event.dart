part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;
  AuthLoginEvent({required this.email, required this.password});
}

final class AuthRegisterEvent extends AuthEvent {
  final String userName;
  final String phoneNumber;
  final String address;
  final String gstNo;
  final String panNo;
  final String email;
  final String password;
  AuthRegisterEvent({
    required this.userName,
    required this.phoneNumber,
    required this.address,
    required this.gstNo,
    required this.panNo,
    required this.email,
    required this.password,
  });
}
