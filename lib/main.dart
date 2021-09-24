import 'package:flutter/material.dart';
import 'package:tencent_video/page/boot.dart';
import 'package:tencent_video/page/initialize.dart';

void main() => bootApp(TencentVideoApp());

class TencentVideoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Boot();
}
