import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // MainAxisAlignment - 주축 정렬
              // start - 시작
              // end - 끝
              // center - 가운데
              // spaceBetween - 요소들을 양 끝에 배치 후 일정한 간격으로 정렬
              // spaceEvenly - 일정한 간격으로 정렬되나, 끝과 끝에도 위젯이 빈 간격으로 시작함
              // spaceAround - spaceEvenly + 끝과 끝의 간격은 1/2
              // mainAxisAlignment: MainAxisAlignment.start,
              // CrossAxisAlignment - 반대축 정렬
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.red,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.orange,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.yellow,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.green,
                    ),
                  ],
                ),
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.orange,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.red,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.orange,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.yellow,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.green,
                    ),
                  ],
                ),
                Container(
                width: 50,
                  height: 50,
                  color: Colors.green,
                )
              ],
            ),
          ),
        ),
    );
  }
}
