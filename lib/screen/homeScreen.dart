import 'package:dio/dio.dart';
import 'package:dust/component/card_title.dart';
import 'package:dust/container/category_card.dart';
import 'package:dust/container/hourly_card.dart';
import 'package:dust/component/main_app_bar.dart';
import 'package:dust/component/main_card.dart';
import 'package:dust/component/main_drawer.dart';
import 'package:dust/const/const_color.dart';
import 'package:dust/const/data.dart';
import 'package:dust/const/status_level.dart';
import 'package:dust/model/stat_and_status_model.dart';
import 'package:dust/model/stat_model.dart';
import 'package:dust/repository/stat_repository.dart';
import 'package:dust/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../const/regions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String region = regions[0];
  bool isExpanded = true;
  ScrollController scrollController = ScrollController();

  @override
  initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    fetchData();
  }

  @override
  dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    try{
      final now = DateTime.now();
      final fetchTime = DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
      );

      final box = Hive.box(ItemCode.PM10.name);

      if(box.values.isNotEmpty && (box.values.last as StatModel).dataTime.isAtSameMomentAs(fetchTime)){
        print('이미 최신 데이터가 있습니다.');
        return;
      }


      List<Future> futures = [];

      for (ItemCode itemCode in ItemCode.values) {
        futures.add(
          StatRepository.fetchData(
            itemCode: itemCode,
          ),
        );
      }
      final results = await Future.wait(futures);

      for (int i = 0; i < results.length; i++) {
        // itemCode
        final key = ItemCode.values[i];
        // List<StatModel>
        final value = results[i];

        final box = Hive.box<StatModel>(key.name);

        for (StatModel stat in value) {
          box.put(stat.dataTime.toString(), stat);
        }
        final  allKeys = box.keys.toList();

        if(allKeys.length > 24){
          // start = start index
          // end = end index
          // ['red', 'orange', 'yellow', 'green', 'blue']
          // .sublist(1,3)
          // ['orange', 'yellow'] no green
          final deleteKeys = allKeys.sublist(0, allKeys.length - 24);

          box.deleteAll(deleteKeys);
        }
      }
    } on DioError catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('인터넷 연결이 원할하지 않습니다.'))
      );
    }
  }

  scrollListener() {
    bool isExpanded = scrollController.offset < 500 - kToolbarHeight;

    if (isExpanded != this.isExpanded) {
      setState(() {
        this.isExpanded = isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box<StatModel>(ItemCode.PM10.name).listenable(),
      builder: (context, box, widget) {
        if(box.values.isEmpty){
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final recentStat = box.values.toList().last as StatModel;
        final status = DataUtils.getStatusFromItemCodeAndValue(
          // PM10
          // box.values.toList().last
          value: recentStat.getLevelFromRegion(region), itemCode: ItemCode.PM10,
        );
        return Scaffold(
          drawer: MainDrawer(
            selectedRegion: region,
            onRegionTap: (String region) {
              setState(() {
                this.region = region;
              });
              Navigator.of(context).pop();
            },
            darkColor: status.darkColor,
            lightColor: status.lightColor,
          ),
          body: Container(
            color: status.primaryColor,
            child: RefreshIndicator(
              onRefresh: () async {
                await fetchData();
              },
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  MainAppBar(
                    region: region,
                    stat: recentStat,
                    status: statusLevel[0],
                    dateTime: recentStat.dataTime,
                    isExpanded: isExpanded,
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CategoryCard(
                          region: region,
                          darkColor: status.darkColor,
                          lightColor: status.lightColor,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        ...ItemCode.values.map(
                          (itemCode) {

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: hourlyCard(
                                darkColor: status.darkColor,
                                lightColor: status.lightColor,
                                region: region, itemcode: itemCode,
                              ),
                            );
                          },
                        ).toList(),
                        SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
