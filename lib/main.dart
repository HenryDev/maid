import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maid/providers/character.dart';
import 'package:maid/providers/model.dart';
import 'package:maid/providers/session.dart';
import 'package:provider/provider.dart';
import 'package:maid/pages/desktop_home.dart';
import 'package:maid/static/memory_manager.dart';
import 'package:maid/providers/theme.dart';
import 'package:maid/pages/mobile_home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MemoryManager.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => Model()),
        ChangeNotifierProvider(create: (context) => Character()),
        ChangeNotifierProvider(create: (context) => Session()),
      ],
      child: const MaidApp(),
    ),
  );
}

class MaidApp extends StatefulWidget {
  const MaidApp({super.key});

  @override
  MaidAppState createState() => MaidAppState();
}

class MaidAppState extends State<MaidApp> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final aspectRatio = screenSize.width / screenSize.height;

    final Widget homePage;
    if (aspectRatio > 0.9) {
      homePage = const DesktopHomePage(title: 'Maid');
    } else {
      homePage = const MobileHomePage(title: 'Maid');
    }

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Maid',
          theme: ThemeProvider.lightTheme(),
          darkTheme: ThemeProvider.darkTheme(),
          themeMode: themeProvider.themeMode,
          home: homePage
        );
      },
    );
  }
}
