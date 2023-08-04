import 'package:dust/screen/test2_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dust/main.dart';

class testScreen extends StatefulWidget {
  const testScreen({super.key});

  @override
  State<testScreen> createState() => _testScreenState();
}

class _testScreenState extends State<testScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextScreen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        ValueListenableBuilder<Box>(valueListenable: Hive.box(testBox).listenable(), builder: (context, box, widget){
          return Column(
            children: box.values.map((e) => Text(e.toString())).toList(),
          );
        },)
          ,ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);
              print('keys = ${box.keys}');
              print('values = ${box.values.toList()}');
            },
            child: Text(
              'Print Box',
            ),
          ),
          ElevatedButton(
            onPressed: () {

              final box = Hive.box(testBox);

              box.put(2, 'test333');


            },
            child: Text(
              'input data',
            ),
          ),ElevatedButton(
            onPressed: () {

              final box = Hive.box(testBox);


              // 데이터를 생성하거나
              // 업데이트할 때
              print(box.get(100));


            },
            child: Text(
              'load some data',
            ),
          ),
          ElevatedButton(
            onPressed: () {

              final box = Hive.box(testBox);

              // 데이터를 생성하거나
              // 업데이트할 때
              box.deleteAt(2);
            },
            child: Text(
              'Delete key',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => Test2Screen())
              );
            },
            child: Text(
              'Next Screen',
            ),
          ),
        ],
      ),
    );
  }
}
