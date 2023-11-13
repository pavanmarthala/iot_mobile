// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names, avoid_print, prefer_const_constructors

import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:iot_mobile_app/pages/landing_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseApi {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> initNotifications() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission: ${settings.authorizationStatus}');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print(
          'User granted provisional permission: ${settings.authorizationStatus}');
    } else {
      print('User denied permission');
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  Future<void> storeTokenInFirestore(String userId, String token) async {
    print('Storing token in Firestore: User ID - $userId, Token - $token');

    if (userId == null || userId.isEmpty) {
      print('Invalid userId: $userId');
      return;
    }

    CollectionReference tokensCollection =
        FirebaseFirestore.instance.collection('UserTokens');

    try {
      await tokensCollection.doc(userId).set({'token': token});
      print('Token stored successfully in Firestore for user: $userId');
    } catch (e, stackTrace) {
      print('Error storing token in Firestore: $e');
      print('Stack Trace: $stackTrace');
    }
  }

  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        AndroidInitializationSettings('@drawable/notificationicon');
    var initializationSetting = InitializationSettings(
      android: androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
      // Handle interaction when the app is active for Android.
      handleMessage(context, message);
    });
  }

  void firebaseInit(BuildContext context) async {
    // String testUserId = "testUser123";
    subscribeToTopic('Iot');
    // getDeviceToken().then((token) {
    //   // Use the test user ID for testing purposes
    //   storeTokenInFirestore(testUserId, token);
    // });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('username');

    if (userId != null) {
      getDeviceToken().then((token) {
        // Store the device token in Firestore
        storeTokenInFirestore(userId, token);
        print('Token stored successfully in Firestore.');
      });
    } else {
      print('User ID not found in SharedPreferences');
    }
    FirebaseMessaging.onMessage.listen((message) async {
      if (kDebugMode) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
        print(message.data.toString());
        print(message.data['type']);
        print(message.data['id']);
      }
      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotifications(message);
      }
      // // Retrieve the user ID from SharedPreferences
    });
  }

  Future<void> showNotifications(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_messages',
      'High Priority Messages',
      importance: Importance.max,
      // sound: RawResourceAndroidNotificationSound('your_custom_sound'), // Replace with your custom sound resource
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            channelDescription: 'Your channel description',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
            ticker: 'ticker',
            icon: '@drawable/notificationicon');

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title.toString(),
      message.notification!.body.toString(),
      notificationDetails,
    );
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }
    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    if (message.data['type'] == 'message') {
      try {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Landingpage(id: message.data['id'] ?? ""),
          ),
        );
      } catch (e) {
        print('Error navigating to Landingpage: $e');
      }
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    await messaging.subscribeToTopic(topic);
    print('Subscribed to topic: $topic');
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await messaging.unsubscribeFromTopic(topic);
    print('Unsubscribed from topic: $topic');
  }
}
