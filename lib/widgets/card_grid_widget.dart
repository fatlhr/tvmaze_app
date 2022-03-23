// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tvmaze_app/pages/detail_page.dart';

class CardGrid extends StatefulWidget {
  final AsyncSnapshot? snapshot;

  const CardGrid({
    Key? key,
    required this.snapshot,
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
      itemCount: widget.snapshot!.data.length,
      itemBuilder: (context, index) {
        String? image = widget.snapshot?.data[index].image?.original;
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DetailPage(id: "1");
                },
              ),
            );
          },
          child: Card(
            child: SizedBox(
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
                                  widget.snapshot?.data[index].image?.medium ??
                                      "",
                                  fit: BoxFit.cover,
                                )
                              : const Center(
                                  child: Text("No Image"),
                                ),
                        ),
                        Positioned(
                          child: IconButton(
                            icon: Icon(Icons.add_circle_sharp),
                            onPressed: () {
                              final snackBar = SnackBar(
                                content: Text('Added to your watchlist'),
                              );
                              setState(() {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              });
                            },
                          ),
                          top: 10,
                          right: 10,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Wrap(
                      children: [
                        Center(
                          child: Text(
                            widget.snapshot?.data[index].name ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Center(
                          child: Text(
                            widget.snapshot?.data[index].premiered ?? "",
                          ),
                        ),
                        Center(
                          child: Text(
                            widget.snapshot?.data[index].rating.average
                                    .toString() ??
                                "",
                          ),
                        ),
                      ],
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
