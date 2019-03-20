import 'package:flutter/material.dart';

class ProgressPage extends StatefulWidget {
  ProgressPage({Key key}) : super(key: key);

  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  List<String> listItems = [];
  final TextEditingController eCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
    );
  }

  @override
  void dispose() {
    eCtrl.dispose();
    super.dispose();
  }
}
