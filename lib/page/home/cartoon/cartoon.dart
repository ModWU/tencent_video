import 'package:flutter/material.dart';

class Cartoon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CartoonState();
}

class _CartoonState extends State<Cartoon> with RestorationMixin {
  final RestorableInt _counter = RestorableInt(0);

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          setState(() {
            _counter.value++;
          });
        },
        child: Column(
          children: [
            Text("cartoon value: ${_counter.value}"),
          ],
        ),
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
