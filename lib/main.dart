import 'package:flutter/material.dart';
import 'package:the_movies_flut/resource/app_resources.dart';

import 'page/mainpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppColors.colorThemePrimary,
      ),
      home: MainPage(),
    );
  }
}
