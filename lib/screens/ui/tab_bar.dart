import 'package:baigiamasis/screens/ui/report.dart';
import 'package:baigiamasis/screens/ui/report_issue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:baigiamasis/screens/login/login_page.dart';
import 'package:baigiamasis/screens/network/authentication.dart';
import 'package:baigiamasis/screens/ui/choose_market.dart';

String titleName = 'Pasirinkti Turgavietę';
int selectedIndex = 0;

class AppTabBar extends StatefulWidget {
  @override
  _AppTabBarState createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar> {
  final email = FirebaseAuth.instance.currentUser.email;

  /*static const TextStyle textStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );*/

  static List<Widget> _widgetOptions = <Widget>[
    ChooseMarketPage(),
    ReportIssue(),
    //ShowProperties(
    //pavilion: "",
    //),
    ShowReport(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      switch (selectedIndex) {
        case 0:
          titleName = 'Turgavietė';
          break;
        case 1:
          titleName = 'Pranešti apie problemą';
          break;
        case 2:
          titleName = 'Ataskaita';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  backgroundColor: Color(0xffE6E6E6),
                  radius: 30,
                  child: Icon(
                    Icons.person,
                    color: Color(0xffCCCCCC),
                  ),
                ),
              ),
              accountName: Text(''),
              accountEmail: Text(
                email,
                style: TextStyle(fontSize: 32),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text('Atsijungti'),
                tileColor: Theme.of(context).backgroundColor,
                onTap: () async {
                  bool signout = await signOutUser();
                  if (signout) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                        (route) => false);
                  }
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(titleName),
      ),
      body: Center(
        child: _widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Pagrindinis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Pranešti apie įvykį',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Ataskaita',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: onItemTapped,
        unselectedItemColor: Colors.black26,
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
