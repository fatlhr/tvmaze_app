// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

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
  Color iconColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 20,
      itemBuilder: (context, index) {
        String? image = widget.data[index].image?.medium;
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
              child: Column(
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
                            onPressed: () {
                              final snackBar = SnackBar(
                                content: Text('Added to your favorites'),
                              );
                              setState(() {
                                Widget body = ListTile(
                                  title: Text(
                                    widget.data[index].name ?? "",
                                  ),
                                  subtitle: Text(
                                    widget.data[index].summary ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                                //send body to watchlistpage
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            WatchListsPage(body: body)));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              });
                            },
                          ),
                          top: 5,
                          right: 5,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    children: [
                      Center(
                        child: Text(
                          widget.data[index].name ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Center(
                        child: Text(
                          widget.data[index].premiered ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Center(
                        child: Text(
                          widget.data[index].rating.average.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
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
