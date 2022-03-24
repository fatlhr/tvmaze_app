import 'package:flutter/material.dart';
import 'package:tvmaze_app/models/all_shows_model.dart';

import '../services/all_services.dart';
import '../widgets/card_grid_widget.dart';
import 'search_page.dart';

class ByGenre extends StatefulWidget {
  const ByGenre({Key? key, required this.genre}) : super(key: key);
  final String? genre;
  @override
  State<ByGenre> createState() => _ByGenreState();
}

class _ByGenreState extends State<ByGenre> {
  Icon customIcon = const Icon(Icons.search);
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.genre!),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchPage()),
                  );
                },
              );
            },
            icon: customIcon,
          )
        ],
        centerTitle: true,
      ),
      body: FutureBuilder<List<AllShows>>(
        future: AllServices.getShowByGenre(widget.genre!),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: CardGrid(snapshot: snapshot),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
