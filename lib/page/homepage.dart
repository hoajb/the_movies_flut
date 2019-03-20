import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> listItems = [];
  final TextEditingController eCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue,);
  }

  @override
  void dispose() {
    eCtrl.dispose();
    super.dispose();
  }
}
