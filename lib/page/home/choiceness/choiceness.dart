import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tencent_video/common/listener/ob.dart';

class Choiceness extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChoicenessState();
}

class _ChoicenessState extends State<Choiceness>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
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
              style: TextStyle(
                backgroundColor: Colors.red,
                height: null
              ),
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
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    print("_ChoicenessState => initState");
    super.initState();
  }

  @override
  void dispose() {
    print("_ChoicenessState => dispose");
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
