// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tvmaze_app/models/search_model.dart';
import 'package:tvmaze_app/services/all_services.dart';

import '../widgets/search_list_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
    //required this.searchResult
  }) : super(key: key);
  //final String searchResult;
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Icon customIcon = const Icon(Icons.cancel);
  TextEditingController searchController = TextEditingController();
  String searchResult = "";
  @override
  Widget build(BuildContext context) {
    Widget customTitle = TextField(
      decoration: InputDecoration(
        hintText: 'type something...',
        hintStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontStyle: FontStyle.italic,
        ),
        border: InputBorder.none,
      ),
      style: TextStyle(
        color: Colors.white,
      ),
      autofocus: true,
      controller: searchController,
      onChanged: (value) => setState(() {
        searchResult = value;
      }),
    );
    return Scaffold(
      appBar: AppBar(
        title: customTitle,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              setState(
                () {
                  if (customIcon.icon == Icons.cancel) {
                    customIcon = const Icon(Icons.search);
                    searchController.clear();
                    searchResult = "";
                    Navigator.pop(context);
                  }
                },
              );
            },
            icon: customIcon,
          )
        ],
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<List<SearchShows?>>(
          future: AllServices.getSearch(searchResult),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data found'));
                } else {
                  return SearchListWidget(snapshot: snapshot);
                }
            }
          },
        ),
      ),
    );
  }
}
