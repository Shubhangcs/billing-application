import 'package:new_billing/features/authentication/domain/entities/register_entity.dart';

class RegisterModel extends RegisterEntity {
  RegisterModel({
    required super.userName,
    required super.email,
    required super.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "user_name": userName,
      "email": email,
      "password": password,
    };
  }
}
