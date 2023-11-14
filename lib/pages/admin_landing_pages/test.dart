import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String subscription;
  final String addressLine1;
  final String addressLine2;
  final String addressLine3;
  final String district;
  final String state;
  final String city;
  final String pinCode;
  final String profileImage;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.subscription,
    required this.addressLine1,
    required this.addressLine2,
    required this.addressLine3,
    required this.district,
    required this.state,
    required this.city,
    required this.pinCode,
    required this.profileImage,
  });
}

class MyApp extends StatelessWidget {
  final User user = User(
    firstName: 'John',
    lastName: 'Doe',
    email: 'john.doe@example.com',
    subscription: 'Premium',
    addressLine1: '123 Main Street',
    addressLine2: 'Apt 4B',
    addressLine3: 'Building XYZ',
    district: 'XYZ District',
    state: 'ABC State',
    city: 'PQR City',
    pinCode: '12345',
    profileImage:
        'assets/language-icon.svg', // Replace with the actual path or URL
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Details',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserDetailsPage(user: user),
    );
  }
}

class UserDetailsPage extends StatelessWidget {
  final User user;

  UserDetailsPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: SvgPicture.asset(
                  user.profileImage,
                  width: 120,
                  height: 120,
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${user.firstName} ${user.lastName}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        user.email,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Subscription',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        user.subscription,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Address',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.addressLine1),
                          Text(user.addressLine2),
                          Text(user.addressLine3),
                          Text(
                              '${user.city}, ${user.state}, ${user.district} - ${user.pinCode}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
