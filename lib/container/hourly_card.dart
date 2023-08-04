import 'package:dust/const/const_color.dart';
import 'package:dust/model/stat_model.dart';
import 'package:dust/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../component/card_title.dart';
import '../component/main_card.dart';

class hourlyCard extends StatelessWidget {
  final Color darkColor;
  final Color lightColor;

  final String region;
  final ItemCode itemcode;

  const hourlyCard({super.key, required this.darkColor, required this.lightColor, required this.region, required this.itemcode});

  @override
  Widget build(BuildContext context) {
    return MainCard(
      backgroundColor: lightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          cardTitle(
            title: '시간별 ${DataUtils.getItemCodeKrString(itemCode: itemcode)}', backgroundColor: darkColor,
          ),
          ValueListenableBuilder<Box>(valueListenable: Hive.box<StatModel>(itemcode.name).listenable(), builder: (context, box, widget)
             => Column(
              children: box.values.toList().reversed.map((stat) => renderRow(stat: stat)).toList(),
             ),),
        ],
      ),
    );
  }

  Widget renderRow({required StatModel stat}){
    final status = DataUtils.getStatusFromItemCodeAndValue(value: stat.getLevelFromRegion(region), itemCode: stat.itemCode,);
   return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          Expanded(child: Text('${stat.dataTime.hour}시')),
          Expanded(
            child: Image.asset(
              status.imagePath,
              height: 20,
            ),
          ),
          Expanded(
            child: Text(
              status.label,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
