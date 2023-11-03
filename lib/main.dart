import 'package:flutter/material.dart';
import 'package:maid/config/theme.dart';
import 'package:maid/pages/home_page.dart';

final maidAppKey = GlobalKey<MaidAppState>();
final homePageKey = GlobalKey<MaidHomePageState>();

void main() {
  runApp(MaidApp(key: maidAppKey));
}

class MaidApp extends StatefulWidget {
  const MaidApp({super.key});

  @override
  MaidAppState createState() => MaidAppState();
}

class MaidAppState extends State<MaidApp> {
  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  _loadTheme() async {
    await MaidTheme.loadThemePreference();
    setState(() {});
  }

  void refreshApp() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maid',
      theme: MaidTheme.theme,
      home: MaidHomePage(key: homePageKey, title: 'Maid'),
    );
  }
}