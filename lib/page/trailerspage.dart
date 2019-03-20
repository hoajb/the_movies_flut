import 'package:flutter/material.dart';

class TrailersPage extends StatefulWidget {
  TrailersPage({Key key}) : super(key: key);

  @override
  _TrailersPageState createState() => _TrailersPageState();
}

class _TrailersPageState extends State<TrailersPage> {
  List<String> listItems = [];
  final TextEditingController eCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red,);
  }

  @override
  void dispose() {
    eCtrl.dispose();
    super.dispose();
  }
}
