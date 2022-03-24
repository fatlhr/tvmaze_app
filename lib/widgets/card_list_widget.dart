// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tvmaze_app/services/all_services.dart';

import '../pages/detail_page.dart';
import '../pages/watchlists_page.dart';

class CardList extends StatefulWidget {
  final List data;

  const CardList({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  Color iconColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 20,
      itemBuilder: (context, index) {
        String? image = widget.data[index].image?.medium;
        String? date;
        if (widget.data[index].premiered != null) {
          date = DateFormat.yMMMMd()
              .format(DateTime.parse(widget.data[index].premiered));
        }
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DetailPage(id: widget.data[index].id.toString());
                },
              ),
            );
          },
          child: Card(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
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
                                      widget.data[index].image?.medium ?? "",
                                      fit: BoxFit.cover,
                                    )
                                  : const Center(
                                      child: Text("No Image"),
                                    ),
                            ),
                            Positioned(
                              child: IconButton(
                                icon: Icon(Icons.add_circle_sharp),
                                color: iconColor,
                                hoverColor: Colors.black,
                                onPressed: () {
                                  final snackBar = SnackBar(
                                    content: Text('Added to your favorites'),
                                  );
                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WatchListsPage(
                                          add: AllServices.addWatchlist(
                                            widget.data[index].id ?? "",
                                            widget.data[index].name ?? "",
                                            widget.data[index].summary ?? "",
                                            image ?? "",
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
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Wrap(
                          children: [
                            Center(
                              child: Text(
                                widget.data[index].name ?? "",
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
                            Center(
                              child: Text(
                                date ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 50,
                    left: 10,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          widget.data[index].rating.average.toString(),
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
