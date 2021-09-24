import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NBA extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NBAState();
}

class _NBAState extends State<NBA> {

  ValueNotifier<int> _valueNotifier = ValueNotifier<int>(1000);

  @override
  Widget build(BuildContext context) {
    print('_NBAState -> build');
   // ChangeNotifierProvider
    return ValueListenableBuilder<int>(
      valueListenable: _valueNotifier,
      //child: ChildBody(),
      builder: (BuildContext context, int value, Widget? child) {
        print('value -> build');
        return ChildBody();
      },
    );
  }

  Stream<int> _loadData() async* {
    await Future<void>.delayed(const Duration(milliseconds: 3000));
    print("加载数据成功!!!");
    /*return Stream<int>.periodic(
        const Duration(milliseconds: 1000), (int _count) => _count++
    );*/
    for (int i = 0; i < 100; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 1000));
      yield i;
    }
  }
}

class ChildBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChildBodyState();
}

class ChildBodyState extends State<ChildBody> {
  @override
  Widget build(BuildContext context) {
    print('ChildBodyState -> build');
    final int data = context.read<int>();

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$data'),
          TextButton(
              onPressed: () {
                final OrderNotifier orderNotifier = context.watch<OrderNotifier>();
                orderNotifier.change(orderNotifier.value + 2);

              },
              child: Text('ADD')),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('ChildBodyState -> didChangeDependencies');
  }
}

class OrderNotifier with ChangeNotifier {
  OrderNotifier(int value) : _value = value;

  int _value;

  int get value => _value;

  void change(int value) {
    if (_value == value) return;
    _value = value;
    notifyListeners();
  }
}
