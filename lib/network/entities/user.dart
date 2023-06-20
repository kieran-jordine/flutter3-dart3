
import 'package:flutter3_dart3/network/entities/address.dart';
import 'package:flutter3_dart3/network/entities/company.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  @Assert('email.contains("@")', 'Invalid email')
  factory User({
    required int id,
    required String name,
    required String username,
    required String email,
    required String phone,
    required String website,
    required Address address,
    required Company company,
  }) = _User;

  User._();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

}