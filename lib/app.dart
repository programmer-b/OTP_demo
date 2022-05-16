import 'package:easy_container/easy_container.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:validus_otp_demo/utils/globals.dart';
import 'package:validus_otp_demo/utils/helpers.dart';
import 'package:validus_otp_demo/widgets/pin_input_field.dart';

part './UI/authentication_screen.dart';
part './UI/verify_phone_number.dart';
part './UI/home_screen.dart';
part './widgets/home_button.dart';

class MyApp extends StatelessWidget {
MyApp({Key? key}) : super(key: key);

  final isLoggedIn = Globals.firebaseUser != null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Validus OTP validation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoggedIn ? const HomeScreen() : const AuthenticationScreen(),
    );
  }
}

