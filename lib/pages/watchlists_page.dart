// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

class WatchListsPage extends StatefulWidget {
  const WatchListsPage({Key? key, this.body}) : super(key: key);

  final Widget? body;
  @override
  State<WatchListsPage> createState() => _WatchListsPageState();
}

class _WatchListsPageState extends State<WatchListsPage> {
  @override
  List<Widget> watchlists = [];
  Future addList() async {
    watchlists.add(widget.body ?? Container());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Watch Lists"),
      ),
      body: FutureBuilder(
        future: addList(),
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      watchlists.add(widget.body ?? Container());
                      setState(() {});
                    },
                    child: Text("add"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      watchlists.removeAt(0);
                      setState(() {});
                    },
                    child: Text("remove"),
                  ),
                ],
              ),
              Column(
                children: watchlists,
              ),
            ],
          );
        },
      ),
    );
  }
}
