import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:the_movies_flut/bloc/bloc.dart';
import 'package:the_movies_flut/page/movielist/movie_list_page.dart';
import 'package:the_movies_flut/resource/app_resources.dart';
import 'package:the_movies_flut/util/alog.dart';

import 'page/mainpage.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  Alog.init();
  runApp(MyApp());
}

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
