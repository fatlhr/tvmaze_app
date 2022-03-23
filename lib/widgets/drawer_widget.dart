// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tvmaze_app/pages/ongoing_page.dart';
import 'package:tvmaze_app/pages/top_page.dart';

import '../pages/watchlists_page.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'TV Maze App',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Top Rated'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Ongoing'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OnGoingPage(),
                ),
              );
            },
          ),
           ListTile(
            title: Text('Watch Lists'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WatchListsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
