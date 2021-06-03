import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tencent_video/common/listener/ob.dart';

class Choiceness extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChoicenessState();
}

class _ChoicenessState extends State<Choiceness>
    with AutomaticKeepAliveClientMixin {
  RefreshController? _refreshController;

  void _onRefresh() async {
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
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SmartRefresher(
      controller: _refreshController!,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.blue,
              child: Text("精选"),
            ),
            Container(
              color: Colors.yellow,
              child: Text(
                "调高度",
                style: TextStyle(backgroundColor: Colors.red, height: null),
                /* strutStyle: StrutStyle(
                leading: 2,
                height: 2,
                //forceStrutHeight: true,
              ),*/
              ),
            ),
            Container(
              color: Colors.black54,
              child: ObWidget(
                builder: (Ob<bool> data) {
                  return Switch(value: data.value!, onChanged: data);
                },
                initialValue: false.ob,
              ),
            ),
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
