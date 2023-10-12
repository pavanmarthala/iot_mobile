class AddUserModel {
  final int email;
  final int mobile;
  final String pin;
  final String preferredLanguage;
  final String role;
  final int subscriptionValidity;
  final int addressLine1;
  final String addressLine2;
  final String addressLine3;
  final String city;
  final int district;
  final int landMark;
  final String pinCode;
  final String state;
  final String firstName;
  final int lastName;
  final int name;
  final String zone;



  AddUserModel({
  required this.email,
  required this.mobile,
  required this.pin,
  required this.preferredLanguage,
  required this.role,
  required this.subscriptionValidity,
  required this.addressLine1,
  required this.addressLine2,
  required this.addressLine3,
  required this.city,
  required this.district,
  required this.landMark,
  required this.pinCode,
  required this.state,
  required this.firstName,
  required this.lastName,
  required this.name,
  required this.zone,

  });

  factory AddUserModel.fromJson(Map<String, dynamic> json) {
    return AddUserModel(
      zone: json['zone'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      pin: json['pin'],
      preferredLanguage: json['preferredLanguage'],
      role: json['role'],
      subscriptionValidity: json['subscriptionValidity'],
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      addressLine3: json['addressLine3'],
      city: json['city'],
      district: json['district'],
      landMark: json['landMark'],
      pinCode: json['pinCode'],
      state: json['state'],
      firstName: json['title'],
      lastName: json['url'],

    );
  }
}
