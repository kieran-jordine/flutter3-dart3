
import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address with _$Address {
  factory Address({
    required String street,
    required String suite,
    required String city,
    required String zipcode,
    @Default(<String, dynamic>{}) Map<String, dynamic> geo,
  }) = _Address;

  Address._();

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

}