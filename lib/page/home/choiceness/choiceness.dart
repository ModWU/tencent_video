import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tencent_video/common/listener/ob.dart';
import 'package:tencent_video/resources/strings.dart';
import '../../base.dart';

class Choiceness extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChoicenessState();
}

class _ChoicenessState extends State<Choiceness>
    with BootMiXin, AutomaticKeepAliveClientMixin {
  RefreshController? _refreshController;

  /*void _onRefresh() async {
    print("onRefresh...");
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController!.refreshCompleted();
    print("onRefresh...finishe");
  }

  void _onLoading() async {
    print("onLoading...");
    await Future.delayed(Duration(milliseconds: 1000));

    _refreshController!.loadComplete();
    print("onLoading...finishe");
  }*/

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SmartRefresher(
      controller: _refreshController!,
      //onRefresh: _onRefresh,
      //onLoading: _onLoading,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: RadioListTile<String>(
                    title: const Text('英文'),
                    value: LanguageCodes.en,
                    groupValue: bootContext.locale.value?.languageCode,
                    onChanged: (String? value) {
                      bootContext.changeLanguage(value);
                    },
                  ),
                ),
                Flexible(
                  child: RadioListTile<String>(
                    title: const Text('中文'),
                    value: LanguageCodes.zh,
                    groupValue: bootContext.locale.value?.languageCode,
                    onChanged: (String? value) {
                      bootContext.changeLanguage(value);
                    },
                  ),
                ),
                Flexible(
                  child: RadioListTile<String>(
                    title: const Text('跟随系统'),
                    value: 'null',
                    groupValue:
                        bootContext.locale.value?.languageCode ?? 'null',
                    onChanged: (String? value) {
                      bootContext.changeLanguage(null);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    _refreshController!.dispose();
    _refreshController = null;
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
