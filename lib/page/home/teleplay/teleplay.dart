import 'package:flutter/material.dart';

class Teleplay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeleplayState();
}

class _TeleplayState extends State<Teleplay> {
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(child: ListView.builder(
            itemExtent: 250.0,
            key: PageStorageKey<String>('pageOne'),
            itemBuilder: (BuildContext context, int index) => Container(
              padding: const EdgeInsets.all(10.0),
              child: Material(
                color: index.isEven ? Colors.cyan : Colors.deepOrange,
                child: Center(
                  child: Text(index.toString()),
                ),
              ),
            ),
          )),
          Expanded(child: ListView.builder(
            itemExtent: 250.0,
            key: PageStorageKey<String>('pageTwo'),
            itemBuilder: (BuildContext context, int index) => Container(
              padding: const EdgeInsets.all(10.0),
              child: Material(
                color: index.isEven ? Colors.cyan : Colors.deepOrange,
                child: Center(
                  child: Text(index.toString()),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
