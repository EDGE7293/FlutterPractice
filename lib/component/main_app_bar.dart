import 'package:dust/const/status_level.dart';
import 'package:dust/model/status_model.dart';
import 'package:dust/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:dust/const/const_color.dart';

import '../model/stat_model.dart';

class MainAppBar extends StatelessWidget {
  final StatusModel status;
  final StatModel stat;
  final String region;
  final DateTime dateTime;
  final bool isExpanded;

  final ts = TextStyle(color: Colors.white, fontSize: 30);

  MainAppBar({super.key, required this.status, required this.stat, required this.region, required this.dateTime, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: isExpanded ? null : Text('$region ${DataUtils.getTimeFromDateTime(dateTime: dateTime)}'),
      centerTitle: true,
      pinned: true,
      expandedHeight: 500,
      backgroundColor: status.primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: kToolbarHeight),
            child: Column(
              children: [
                Text(
                  region,
                  style: ts.copyWith(
                      fontSize: 40, fontWeight: FontWeight.w700),
                ),
                Text(
                  DataUtils.getTimeFromDateTime(dateTime: stat.dataTime),
                  style: ts.copyWith(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20,),
                Image.asset(
                  status.imagePath,
                  width: MediaQuery.of(context).size.width / 2,
                ),
                SizedBox(height: 20,),
                Text(
                  status.label,
                  style: ts.copyWith(
                      fontSize: 40, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8,),
                Text(
                  status.comment,
                  style: ts.copyWith(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
