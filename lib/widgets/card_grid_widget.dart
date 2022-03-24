// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tvmaze_app/pages/detail_page.dart';

import '../models/watchlist_model.dart';
import '../pages/watchlists_page.dart';
import '../services/all_services.dart';

class CardGrid extends StatefulWidget {
  final AsyncSnapshot? snapshot;
  final List<Watchlist>? watchlist;
  final bool isWatchlist;
  const CardGrid({
    Key? key,
    this.snapshot,
    this.watchlist,
    this.isWatchlist = false,
  }) : super(key: key);

  @override
  State<CardGrid> createState() => _CardGridState();
}

class _CardGridState extends State<CardGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: MediaQuery.of(context).size.height / 3,
        childAspectRatio: 0.8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: widget.isWatchlist
          ? widget.watchlist!.length
          : widget.snapshot!.data.length,
      itemBuilder: (context, index) {
        String? image = widget.isWatchlist
            ? widget.watchlist![index].image
            : widget.snapshot?.data[index].image?.original;
        String? date;
        String? summary;
        if (widget.snapshot?.data[index].premiered != null) {
          date = DateFormat.yMMMMd()
              .format(DateTime.parse(widget.snapshot?.data[index].premiered));
        }
        if (widget.watchlist?[index].summary != null) {
          summary = widget.watchlist?[index].summary
              .replaceAll("<p>", "")
              .replaceAll("</p>", "")
              .replaceAll("<b>", "")
              .replaceAll("</b>", "")
              .replaceAll("<i", "")
              .replaceAll("</i>", "");
        }
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DetailPage(
                      id: widget.isWatchlist
                          ? widget.watchlist![index].id.toString()
                          : widget.snapshot!.data[index].id.toString());
                },
              ),
            );
          },
          child: Card(
            child: SizedBox(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              color: Colors.grey,
                              child: image != null
                                  ? Image.network(
                                      widget.isWatchlist
                                          ? widget.watchlist![index].image
                                          : widget.snapshot?.data[index].image
                                                  ?.medium ??
                                              "",
                                      fit: BoxFit.cover,
                                    )
                                  : const Center(
                                      child: Text("No Image"),
                                    ),
                            ),
                            Positioned(
                              child: IconButton(
                                icon: widget.isWatchlist
                                    ? Icon(Icons.delete)
                                    : Icon(Icons.add_circle_sharp),
                                hoverColor: Colors.black,
                                color: Colors.white,
                                onPressed: () {
                                  final snackBar = SnackBar(
                                    content: widget.isWatchlist
                                        ? Text('Deleted from your watchlist')
                                        : Text('Added to your watchlist'),
                                  );
                                  setState(() {
                                    widget.isWatchlist
                                        ? widget.watchlist!.removeAt(index)
                                        : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  WatchListsPage(
                                                add: AllServices.addWatchlist(
                                                  widget
                                                      .snapshot?.data[index].id,
                                                  widget.snapshot?.data[index]
                                                          .name ??
                                                      "",
                                                  widget.snapshot?.data[index]
                                                          .summary ??
                                                      "",
                                                  widget.snapshot?.data[index]
                                                          .image?.original ??
                                                      "",
                                                ),
                                              ),
                                            ),
                                          );

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  });
                                },
                              ),
                              top: 1.5,
                              right: 1.5,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          children: [
                            Center(
                              child: Text(
                                widget.isWatchlist
                                    ? widget.watchlist![index].title
                                    : widget.snapshot?.data[index].name ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            widget.isWatchlist
                                ? Center(
                                    child: Text(
                                      summary ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      date ?? "",
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  widget.isWatchlist
                      ? Container()
                      : Positioned(
                          bottom: 50,
                          left: 10,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Center(
                              child: Text(
                                widget.isWatchlist
                                    ? ""
                                    : widget.snapshot?.data[index].rating
                                            .average
                                            .toString() ??
                                        "-",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.green),
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
