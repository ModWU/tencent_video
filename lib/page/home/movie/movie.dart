import 'package:flutter/material.dart';

class Movie extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MovieState();
}

class _MovieState extends State<Movie> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("电影"),
    );
  }

}