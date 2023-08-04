import 'package:dust/component/card_title.dart';
import 'package:dust/component/main_card.dart';
import 'package:dust/model/stat_and_status_model.dart';
import 'package:dust/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/stat_model.dart';
import '../component/main_stat.dart';

class CategoryCard extends StatelessWidget {
  final String region;
  final Color darkColor;
  final Color lightColor;

  const CategoryCard(
      {Key? key,
      required this.region,
      required this.darkColor,
      required this.lightColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: MainCard(
        backgroundColor: lightColor,
        child: LayoutBuilder(builder: (context, constraint) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              cardTitle(
                backgroundColor: darkColor,
                title: '종류별 통계',
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: PageScrollPhysics(),
                  children: ItemCode.values
                      .map((ItemCode itemCode) => ValueListenableBuilder<Box>(
                                valueListenable:
                                    Hive.box<StatModel>(itemCode.name)
                                        .listenable(),
                                builder: (context, box, widget) {
                                  final stat = (box.values.last as StatModel);
                                  final status =
                                      DataUtils.getStatusFromItemCodeAndValue(
                                    value: stat.getLevelFromRegion(region),
                                    itemCode: itemCode,
                                  );

                                  return MainStat(
                                    category: DataUtils.getItemCodeKrString(
                                        itemCode: itemCode),
                                    imgPath: status.imagePath,
                                    level: status.label,
                                    stat: '${stat.getLevelFromRegion(
                                      region,
                                    )}${DataUtils.getUnitFromItemCode(itemCode: itemCode)}',
                                    width: constraint.maxWidth / 3,
                                  );
                                },
                              )
                          /* List.generate(
                    20,
                    (index) => MainStat(
                      width: constraint.maxWidth / 3,
                      category: '미세먼지$index',
                      imgPath: 'asset/img/best.png',
                      level: '최고',
                      stat: '0㎍/㎥',
                    ),
                  ),*/
                          )
                      .toList(),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
