// To parse this JSON data, do
//
//     final adduserModel = adduserModelFromJson(jsonString);

import 'dart:convert';

AdduserModel adduserModelFromJson(String str) =>
    AdduserModel.fromJson(json.decode(str));

String adduserModelToJson(AdduserModel data) => json.encode(data.toJson());

class AdduserModel {
  bool active;
  String email;
  String mobile;
  String pin;
  String preferredLanguage;
  String role;
  String subscriptionValidity;
  UserDetails userDetails;
  String zone;

  AdduserModel({
    required this.active,
    required this.email,
    required this.mobile,
    required this.pin,
    required this.preferredLanguage,
    required this.role,
    required this.subscriptionValidity,
    required this.userDetails,
    required this.zone,
  });

  factory AdduserModel.fromJson(Map<String, dynamic> json) => AdduserModel(
        active: json["active"],
        email: json["email"],
        mobile: json["mobile"],
        pin: json["pin"],
        preferredLanguage: json["preferredLanguage"],
        role: json["role"],
        subscriptionValidity: json["subscriptionValidity"],
        userDetails: UserDetails.fromJson(json["userDetails"]),
        zone: json["zone"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "email": email,
        "mobile": mobile,
        "pin": pin,
        "preferredLanguage": preferredLanguage,
        "role": role,
        "subscriptionValidity": subscriptionValidity,
        "userDetails": userDetails.toJson(),
        "zone": zone,
      };
}

class UserDetails {
  Address address;
  String firstName;
  String lastName;
  String name;

  UserDetails({
    required this.address,
    required this.firstName,
    required this.lastName,
    required this.name,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        address: Address.fromJson(json["address"]),
        firstName: json["firstName"],
        lastName: json["lastName"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "address": address.toJson(),
        "firstName": firstName,
        "lastName": lastName,
        "name": name,
      };
}

class Address {
  String addressLine1;
  String addressLine2;
  String addressLine3;
  String city;
  String district;
  String landMark;
  String pinCode;
  String state;

  Address({
    required this.addressLine1,
    required this.addressLine2,
    required this.addressLine3,
    required this.city,
    required this.district,
    required this.landMark,
    required this.pinCode,
    required this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        addressLine3: json["addressLine3"],
        city: json["city"],
        district: json["district"],
        landMark: json["landMark"],
        pinCode: json["pinCode"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "addressLine3": addressLine3,
        "city": city,
        "district": district,
        "landMark": landMark,
        "pinCode": pinCode,
        "state": state,
      };
}
