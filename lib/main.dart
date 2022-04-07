import 'package:flutter/material.dart';
import 'package:lenswear_app/navbar.dart';
import 'package:lenswear_app/util/theme_data.dart';
import 'package:lenswear_app/views/home_screen/home_screen.dart';
import 'package:lenswear_app/views/search_screen/search_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //all widgets are rendered here
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _screenIndex = 1;
  final List<Widget> _screens = [
    const SearchScreen(),
    const HomeScreen(),
    // const FavoriteScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lenswearThemeData,
      title: "lenswear",
      home: Scaffold(
        backgroundColor: primaryColor,
        body: _screens[_screenIndex],
        bottomNavigationBar: MyNavBar(
          activeIndex: _screenIndex,
          onPressed: (i) => setState(() => _screenIndex = i),
        ),
      ),
    );
  }
}
