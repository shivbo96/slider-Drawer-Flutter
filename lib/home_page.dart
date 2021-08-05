import 'dart:math';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//let declare the val variable
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // let's start by creating background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade300,
                  Colors.blue.shade800,
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topCenter,
              ),
            ),
          ),

          //now let's make the navigation Menu

          _sideDrawer(),

          //now lets make main screen and we will wrap our main screen in the tween animation builder
          // which will allow us to animate the screen

          _mainScreen(),

          GestureDetector(
            // onTap: () {
            //   setState(() {
            //     value == 0 ? value = 1 : value = 0;
            //   });
            // }
            onHorizontalDragUpdate: (e) {
              print(e.delta.dx);
              if (e.delta.dx > 0) {
                setState(() {
                  value = 1;
                });
              } else {
                setState(() {
                  value = 0;
                });
              }
            },
          )
        ],
      ),
    );
  }

  _mainScreen() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: value),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
      builder: (BuildContext context, double size, Widget? child) {
        return (
            //lets create transform widgets
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..setEntry(
                    0, 3, 250 * size) //this line allow us to  translate the screen
                ..rotateY((pi / 6) * size),
              child: Scaffold(
                appBar: AppBar(
                  title: Text("3D Drawer Menu"),
                  leading: Builder(
                    builder: (context) => IconButton(
                      onPressed: () {
                        // Scaffold.of(context).openDrawer();
                        setState(() {
                          value == 0 ? value = 1 : value = 0;
                        });
                      },
                      icon: Icon(Icons.menu),
                    ),
                  ),
                ),
                body: Center(child: Text("Swipe right to open menu ===>")),
              ),
            ));
      },
    );
  }

  _sideDrawer() {
    return SafeArea(
      child: Container(
        width: 200,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://avatars.githubusercontent.com/u/37922543?v=4"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Shivam Mishra",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Home",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    title: Text(
                      "profile",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Settings",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Log Out",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}