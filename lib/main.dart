import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:your_ride/Themes/thems.dart';
import 'package:your_ride/screens/main%20screen.dart';
import 'package:your_ride/screens/resister%20screen.dart';
import 'package:your_ride/splesh%20screen/splesh%20screen.dart';
import 'firebase_options.dart';


Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: mytheme.lightTheme,
      darkTheme: mytheme.darkTheme,
      debugShowCheckedModeBanner: false                                                                                                                                                     ,
      home:splesh(),
    );
  }
}
