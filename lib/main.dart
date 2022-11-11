import 'package:do_something/auth_binding.dart';
import 'package:do_something/root.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      home: Root(),
      title: 'Do Something',
      theme: ThemeData(
        fontFamily: 'Lexend',
        primaryColor: const Color(0xFF010101),
      ),
    );
  }
}
