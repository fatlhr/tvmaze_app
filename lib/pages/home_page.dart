// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../services/all_services.dart';
import '../widgets/card_list_widget.dart';
import '../widgets/drawer_widget.dart';
import 'ongoing_page.dart';
import 'search_page.dart';
import 'top_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('TV Maze App');
  TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: customSearchBar,
        automaticallyImplyLeading: false,
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                return _key.currentState!.openDrawer();
              },
              icon: Icon(Icons.menu));
        }),
        actions: [
          IconButton(
            onPressed: () {
              setState(
                () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchPage()));
                },
              );
            },
            icon: customIcon,
          )
        ],
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Future.wait(
          [
            AllServices.getShows("running"),
            AllServices.getShows("top"),
          ],
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                var data = snapshot.data! as List;
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "OnGoing Shows",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          InkWell(
                            child: Text("Show more >"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OnGoingPage()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height / 3,
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: CardList(data: data[0]),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Top Shows",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          InkWell(
                            child: Text("Show more >"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TopPage()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height / 3,
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: CardList(data: data[1]),
                      ),
                    ),
                  ],
                );
              }
          }
        },
      ),
    );
  }
}

