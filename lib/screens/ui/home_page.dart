import 'package:flutter/material.dart';
import 'package:baigiamasis/screens/ui/tab_bar.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pasirinkti Turgavietę',
      home: AppTabBar(),
    );
  }
}
