import 'package:flutter/material.dart';
import 'package:projectndc/user_views/app_user_view/app_notice_board.dart';
import 'package:projectndc/user_views/profile.dart';
import 'package:projectndc/user_views/timeline.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Bodypage extends StatefulWidget {
  const Bodypage({Key? key}) : super(key: key);

  @override
  State<Bodypage> createState() => _BodypageState();
}

class _BodypageState extends State<Bodypage> {

  List <Color> colorlist = <Color>[
    const Color(0xFFC7F8FF),
    const Color(0xFFC6E2EF),
    const Color(0xFF4988CB)
  ];

  int _selectedIndex = 0;
  late Color navcolor = colorlist[0];

  static const List<Widget> _widgetOptions = <Widget>[
    // Text(
    //   'Notice',
    //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    // ),
    //Profile page
    AppNoticeBoard(),
    //AppNoitceBoard2(),
    //WebViewExample(),
    Profile(),
    //Timeline
    User_timeline(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      navcolor = colorlist[index];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async{
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          if(_selectedIndex > 0) {
            setState(() {
              _selectedIndex = 0;
            });
            print(sharedPreferences.getBool("rememberme"));
            return false;
          }else if(sharedPreferences.getBool("rememberme") == null){
            print(sharedPreferences.getBool("rememberme"));
            return true;
          }else{
            return false;
          }

        },
    child: Scaffold(
      // backgroundColor: Color(0x8DC65585),

      // appBar: AppBar(
      //   automaticallyImplyLeading: false,  //to remove back button
      //   title: const Text('Narasinha Dutt College'),
      //   actions: <Widget>[
      //     Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         IconButton(
      //           icon: Icon(
      //             Icons.logout_outlined,
      //             color: Colors.white,
      //           ),
      //           onPressed: () {
      //             Navigator.push(context, CupertinoPageRoute(builder: (context) => const LoginPage()));
      //           },
      //         ),
      //         Text("Log out",
      //           style: TextStyle(
      //             fontSize: 1*SizeConfig.heightmultiplier,
      //           ),
      //         )
      //       ],
      //
      //
      //     )
      //   ],
      // ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/b3.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: AnimatedSwitcher(
              duration:  const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },

              child: _widgetOptions.elementAt(_selectedIndex)
          ),
        ),
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.business),
      //       label: 'Profile',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.school),
      //       label: 'Timeline',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colour.BLUE_BACKGROUND,
      //   onTap: _onItemTapped,
      // ),

      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white,
        backgroundColor: navcolor,
        index: _selectedIndex,
        // Colors.lightBlue.shade100,
        animationDuration: const Duration(milliseconds: 450),
        items: const [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.view_list),
                Text("Notice",
                  style: TextStyle(
                    fontFamily: 'Kanit',
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person),
                Text("Profile",
                  style: TextStyle(
                    fontFamily: 'Kanit',
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.timeline),
                Text("Timeline",
                  style: TextStyle(
                    fontFamily: 'Kanit',
                  ),
                ),
              ],
            ),
        ],
        onTap: _onItemTapped,
      ),

    ),
    );
  }
}

