import 'package:flutter/material.dart';
import 'package:tencent_video/common/listener/data_notifier.dart';
import 'package:tencent_video/common/listener/ob.dart';

class Cartoon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CartoonState();
}

enum Type {
  search, refresh, changeName
}

/*class PageAController with DataNotifier {
  
  String? _searchKey;
  String get searchKey => _searchKey!;

  set searchKey(String value) {
   if (value == _searchKey) return;
   _searchKey = value;
    notifyListeners('search');
  }

  void addSearchListener(Type type, VoidCallback listener) {
    addListener(type, listener);
  }

  void removeSearchListener(Type type, VoidCallback listener) {
    removeListenerByKey(type, listener);
  }

}*/

class _CartoonState extends State<Cartoon> with RestorationMixin {
  final RestorableDouble _counter = RestorableDouble(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        children: [
          SliderTheme(
            data: const SliderThemeData(
              thumbColor: Colors.deepOrangeAccent,
              activeTrackColor: Colors.redAccent,
              inactiveTrackColor: Colors.deepPurpleAccent,
              trackHeight: 2.0,
              showValueIndicator: ShowValueIndicator.always,
              valueIndicatorShape: PaddleSliderValueIndicatorShape(),
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
              valueIndicatorTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            child: ObWidget(
              builder: (Ob<double> data) {
                return Slider(
                  value: data.value!,
                  onChanged: (double val) {
                    data.value = double.tryParse(val.toStringAsPrecision(2));
                  },
                  onChangeStart: (data) {
                    print('start:$data');
                  },
                  onChangeEnd: (data) {
                    print('end:$data');
                  },
                  min: 0.0,
                  max: 10.0,
                  //divisions: 1,
                  label: '进度: ${data.value}',
                  //activeColor: Colors.green,
                  //inactiveColor: Colors.grey,
                  semanticFormatterCallback: (double newValue) {
                    return '${newValue.round()} dollars}';
                  },
                );
              },
              initialValue: _counter.value.ob,
            ),
          ),
        ],
      ),
    );
  }

  @override
  String? get restorationId => "cartoon";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_counter, 'count');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }
}