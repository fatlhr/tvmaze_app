// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tvmaze_app/models/watchlist_model.dart';
import 'package:hive/hive.dart';
import 'package:tvmaze_app/widgets/card_grid_widget.dart';

class WatchListsPage extends StatefulWidget {
  const WatchListsPage({Key? key, this.add}) : super(key: key);

  final Future<dynamic>? add;
  @override
  State<WatchListsPage> createState() => _WatchListsPageState();
}

class _WatchListsPageState extends State<WatchListsPage> {
  @override
  //List<Watchlist> watchlist = [];

  @override
  // void dispose() {
  //   Hive.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Watchlist"),
      ),
      body: ValueListenableBuilder<Box<Watchlist>>(
        valueListenable: Hive.box<Watchlist>('watchlist').listenable(),
        builder: (context, box, _) {
          final watchlist = box.values.toList().cast<Watchlist>();
          return buildContent(watchlist);
        },
      ),
    );
  }

  Widget buildContent(List<Watchlist> watchlist) {
    if (watchlist.isEmpty) {
      return Center(
        child: Text("No Watchlist"),
      );
    }
    return CardGrid(watchlist: watchlist, isWatchlist: true);
  }
}
