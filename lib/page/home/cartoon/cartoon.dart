import 'package:flutter/material.dart';

class Cartoon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CartoonState();
}

class _CartoonState extends State<Cartoon> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("动漫"),
    );
  }

}