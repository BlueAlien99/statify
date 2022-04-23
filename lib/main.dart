import 'package:flutter/material.dart' hide ConnectionState;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:statify/connector.dart';
import 'package:statify/dialog_manager.dart';
import 'package:statify/screens/library_screen.dart';
import 'package:statify/screens/search_screen.dart';
import 'package:statify/screens/home_screen.dart';
import 'package:statify/widgets/navbar.dart';

import 'dart:async';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Statify',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentViewIndex = 0;

  static const List<Widget> _screens = [HomeScreen(), SearchScreen(), LibraryScreen()];

  @override
  void initState() {
    super.initState();
    Connector().subscribeConnectionState().listen((event) {
      DialogManager().popAll(context);
      switch (event) {
        case ConnectionState.initializing:
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: DialogManager().connectingDialogBuilder);
          break;
        case ConnectionState.error:
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: DialogManager().connectionErrorDialogBuilder);
          break;
        default:
          break;
      }
    });
    Connector().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screens.elementAt(_currentViewIndex),
      ),
      extendBody: true,
      bottomNavigationBar: Navbar(
          idx: _currentViewIndex,
          setIdx: (newIdx) => setState(() {
                _currentViewIndex = newIdx;
              })),
    );
  }
}
