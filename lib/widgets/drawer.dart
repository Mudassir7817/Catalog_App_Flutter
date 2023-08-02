import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.grey,
        child: ListView(
          children: const [
            DrawerHeader(
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  accountName: Text(
                    "Syed Mudassir Hussain Shah ",
                    style: TextStyle(color: Colors.black),
                  ),
                  accountEmail: Text("mdsrshah7817@gmail.com",
                      style: TextStyle(color: Colors.black)),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/MyPic_drawer.jpeg"),
                  ),
                )),
            ListTile(
                leading: Icon(CupertinoIcons.home),
                iconColor: Colors.black,
                title: Text(
                  "home",
                  textScaleFactor: 1.3,
                  style: TextStyle(color: Colors.black),
                )),
          ],
        ),
      ),
    );
  }
}
