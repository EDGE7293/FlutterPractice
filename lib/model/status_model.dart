import 'package:flutter/material.dart';
class StatusModel{
  //단계
  final int level;

  // 단계 이름
  final String label;

  // 주색상
  final Color primaryColor;

  // 어두운 색상
  final Color darkColor;

  // 밝은 색상
  final Color lightColor;

  // 폰트 색상
  final Color detailFontColor;

  final String imagePath;

  final String comment;
  // 미세먼지 최소치
  final double minFineDust;
  // 초미세먼지 최소치
  final double minUltraFineDust;
  // 오존 최소치
  final double minO3;
  // 이산화 질소 최소치
  final double minNO2;
  // 일산화탄소 최소치
  final double minCO;
  // 이황산가스 최소치
  final double minSO2;

  StatusModel({
  required this.level,
  required this.label,
  required this.primaryColor,
  required this.darkColor,
  required this.lightColor,
  required this.detailFontColor,
  required this.imagePath,
  required this.comment,
  required this.minFineDust,
  required this.minUltraFineDust,
  required this.minO3,
  required this.minNO2,
  required this.minCO,
  required this.minSO2,
  });
}