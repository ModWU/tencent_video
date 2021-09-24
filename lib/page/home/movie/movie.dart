import 'dart:math';
import 'package:flutter/material.dart';

class Movie extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MovieState();
}

class _MovieState extends State<Movie> {

  final Random _random = Random();

  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  void didUpdateWidget(covariant Movie oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.jumpTo(0);
  }


  @override
  Widget build(BuildContext context) {
    return const Text('Hi');
  }
}
