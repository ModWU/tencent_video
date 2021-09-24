import 'package:flutter/material.dart';
import 'package:tencent_video/common/listener/data_notifier.dart';
import 'package:tencent_video/common/listener/ob.dart';
import 'package:tencent_video/common/util/countdown.dart';

class Cartoon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CartoonState();
}

class _CartoonState extends State<Cartoon> with RestorationMixin {
  final RestorableDouble _counter = RestorableDouble(0);

  bool _countdownFinish = false;

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
            child: ObWidget<double>(
              builder: (Observer<double> data) {
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
          CountdownWidget(const Duration(seconds: 12), builder:
              (BuildContext context, Duration remaining, String formatStr) {
            return Text(formatStr);
          }, onFinish: () {
            setState(() {
              _countdownFinish = true;
            });
          },),
          Text(_countdownFinish?"finish":"loading")
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
