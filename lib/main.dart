import 'package:flutter/material.dart' hide ConnectionState;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:statify/connector.dart';
import 'package:statify/connection_dialogs.dart';
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
  final Color backgroundColor = const Color.fromRGBO(18, 18, 18, 1);

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Statify',
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: backgroundColor,
          dialogBackgroundColor: backgroundColor,
          indicatorColor: Colors.greenAccent,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            brightness: Brightness.dark,
            secondary: Colors.black,
          )),
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  int _currentViewIndex = 0;

  static const List<Widget> _screens = [HomeScreen(), SearchScreen(), LibraryScreen()];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    Connector().subscribeConnectionState().listen((event) {
      popAllConnectionStateDialogs(context);
      switch (event) {
        case ConnectionState.initializing:
          showConnectionDialog(context, connectingDialogBuilder);
          break;
        case ConnectionState.error:
          showConnectionDialog(context, connectionErrorDialogBuilder);
          break;
        default:
          break;
      }
    });
    Connector().init();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Connector().connectToRemote();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(alignment: Alignment.bottomCenter, children: [
      Center(
        child: _screens.elementAt(_currentViewIndex),
      ),
      Navbar(
          idx: _currentViewIndex,
          setIdx: (newIdx) => setState(() {
                _currentViewIndex = newIdx;
              }))
    ]));
  }
}
