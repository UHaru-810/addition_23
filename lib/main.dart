import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'components.dart';
import 'firebase_options.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, //縦固定
  ]);

  runApp(const Addition23());
}

class Addition23 extends StatelessWidget {
  const Addition23({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Addition 23',
      theme: ThemeData(
        primaryColor: ColorLibrary.themePrimary,
        fontFamily: 'NotoSansJP',
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: ColorLibrary.themePrimary,
          selectionColor: ColorLibrary.themeSecondary,
          selectionHandleColor: ColorLibrary.themeSecondary,
        ),
      ),
      home: const Home(),
    );
  }
}
