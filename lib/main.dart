import 'package:dust/model/stat_model.dart';
import 'package:dust/screen/homeScreen.dart';
import 'package:dust/screen/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

const testBox = 'test';


void main()  async{
  await Hive.initFlutter();

  Hive.registerAdapter<StatModel>(StatModelAdapter());
  Hive.registerAdapter<ItemCode>(ItemCodeAdapter());

  await Hive.openBox(testBox);

  for(ItemCode itemcode in ItemCode.values){
    await Hive.openBox<StatModel>(itemcode.name);
  }

  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'Sunflower',
    ),
    home: HomeScreen(),
  ),
  );
}
