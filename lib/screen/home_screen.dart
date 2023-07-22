import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  final Color color;

  const HomeScreen({super.key, required this.color});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: widget.color,
    );
  }
}
