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
          CountdownBuilder(const Duration(seconds: 12), builder:
              (BuildContext context, Duration remaining, String formatStr) {
            return Text(formatStr);
          }, onFinish: () {
            setState(() {
              _countdownFinish = true;
            });
          },),
          Text(_countdownFinish?"finish":"loading"),
          Hero(
            tag: 'image',
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(PageRouteBuilder<double>(
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return NewApp();
                  },
                  transitionDuration: const Duration(milliseconds: 3000),
                  maintainState: false,
                  reverseTransitionDuration:
                  const Duration(milliseconds: 3000),
                  //opaque: false,
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ));
              },
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                alignment: Alignment.center,
                child: Text("haha"),
              ),
            ),
          )
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

class NewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'image',
      flightShuttleBuilder: (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
        ) {
          return this;
        },
      child: Scaffold(
        body: ListView(
          children: List.generate(100, (index) => Text("$index")).toList(),
        ),
      ),
    );
  }



}
