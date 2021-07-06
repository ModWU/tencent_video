import 'package:flutter/material.dart';
import 'package:tencent_video/page/boot.dart';
import 'common/utils/app_utils.dart';

void main() {
  runApp(TencentVideoApp());
  AppUtils.setAppSystemUIOverlayStyle();
}

class TencentVideoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Boot();
}
