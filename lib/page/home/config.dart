import 'package:flutter/material.dart';
import 'package:tencent_video/generated/l10n.dart';
import 'package:tencent_video/page/home/cartoon/cartoon.dart';
import 'package:tencent_video/page/home/choiceness/choiceness.dart';
import 'package:tencent_video/page/home/discover/discover.dart';
import 'package:tencent_video/page/home/documentary/documentary.dart';
import 'package:tencent_video/page/home/movie/movie.dart';
import 'package:tencent_video/page/home/nba/nba.dart';
import 'package:tencent_video/page/home/subscribe/subscribe.dart';
import 'package:tencent_video/page/home/teleplay/teleplay.dart';
import 'package:tencent_video/page/home/variety/variety.dart';

import 'children/children.dart';
class HomeConfigs {

  HomeConfigs._();

  static List<Widget> getViews(BuildContext context) {
    return [
      Subscribe(),
      Choiceness(),
      Discover(),
      Teleplay(),
      Movie(),
      Variety(),
      Children(),
      Cartoon(),
      Documentary(),
      for (int i = 0; i < 10; i++)
        NBA(),
    ];
  }

  static int get length => 19;

  static List<Widget> getTabs(BuildContext context) {
     return [
      Tab(text: S.of(context).sub_txt),
      Tab(text: S.of(context).cho_txt),
      Tab(text: S.of(context).dis_txt),
      Tab(text: S.of(context).tel_txt),
      Tab(text: S.of(context).mov_txt),
      Tab(text: S.of(context).var_txt),
      Tab(text: S.of(context).chi_txt),
      Tab(text: S.of(context).car_txt),
      Tab(text: S.of(context).doc_txt),
      for (int i = 0; i < 10; i++)
        Tab(text: S.of(context).nba_txt),
    ];
  }
}