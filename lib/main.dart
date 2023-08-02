import 'package:catalog_app/Pages/Cart.dart';
import 'package:catalog_app/Pages/home_Page.dart';
import 'package:catalog_app/core/store.dart';
import 'package:catalog_app/utils/MyRoutes.dart';
import 'package:catalog_app/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'Pages/Login_Page.dart';

void main() {
  runApp(VxState(store: MyStore(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.DarkTheme(context),
      initialRoute: MyRoutes.Loginroute,
      routes: {
        "/": (context) => LoginPage(),
        MyRoutes.homeroute: (context) => homePage(),
        MyRoutes.Loginroute: (context) => LoginPage(),
        MyRoutes.cartroute: (context) => Cart(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
