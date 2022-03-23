// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../models/detail_show_model.dart';
import '../services/all_services.dart';
import 'package:intl/intl.dart';

import 'search_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Show Details');
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customSearchBar,
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
                      MaterialPageRoute(
                          builder: (context) => const SearchPage()));
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
        child: FutureBuilder(
          future: Future.wait(
            [
              AllServices.getDetail(widget.id.toString()),
              AllServices.getCast(widget.id.toString()),
              AllServices.getEpisodes(widget.id.toString()),
            ],
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data == null) {
                  return const Center(child: Text('No data found'));
                } else {
                  var data = snapshot.data! as List;
                  String? img = data[0]?.image?.medium;
                  String? summary;

                  String? title;

                  if (data[0]?.premiered != null && data[0]?.name != null) {
                    String year = DateFormat.y().format(data[0]!.premiered!);
                    String name = data[0]!.name ?? "No Title";
                    title = name + " (" + year + ")";
                  }
                  if (data[0]?.name != null && data[0]?.premiered == null) {
                    String year = "-";
                    String name = data[0]!.name ?? "No Title";
                    title = name + " (" + year + ")";
                  }
                  if (data[0]?.summary != null) {
                    summary = data[0]!
                        .summary!
                        .replaceAll("<p>", "")
                        .replaceAll("</p>", "")
                        .replaceAll("<b>", "")
                        .replaceAll("</b>", "")
                        .replaceAll("<i", "")
                        .replaceAll("</i>", "");
                  }
                  return ListView(
                    //shrinkWrap: true,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3.5,
                            width: MediaQuery.of(context).size.width,
                            child: img != null
                                ? Image.network(
                                    img,
                                    fit: BoxFit.cover,
                                  )
                                : const Center(
                                    child: Text("No Image"),
                                  ),
                          ),
                          Positioned(
                            top: 15,
                            left: 15,
                            bottom: 15,
                            child: img != null
                                ? Card(
                                    child: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Image.network(
                                        img,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : const Center(
                                    child: Text("No Image"),
                                  ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          title ?? 'No Title',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          data[0]?.genres?.join(', ') ?? 'No Genres',
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 10,
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  data[0]?.status ?? "No Status",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const VerticalDivider(
                              color: Colors.grey,
                            ),
                            Flexible(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  data[0]?.rating?.average.toString() ??
                                      'No Rate',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Summary",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        summary ?? 'No Summary',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Cast",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: data[1]?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 2.2,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Image.network(
                                          data[1][index]
                                                  ?.person
                                                  .image
                                                  ?.medium ??
                                              "https://via.placeholder.com/300",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Center(
                                      child: Text(
                                        data[1][index]?.person.name ??
                                            "No Name",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Center(
                                      child: Text(
                                        data[1][index]?.character.name ?? "-",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ExpansionTile(
                        title: Text(
                          "Episode List",
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        children: [
                          SizedBox(
                            height: 500,
                            width: double.maxFinite,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: data[2]!.length ?? 0,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    title: Text(
                                        "Season ${data[2][index]?.season} Episode ${data[2][index]?.number}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Text(
                                              data[2][index]?.name ?? "-",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Text(
                                            data[2][index]
                                                    ?.airdate
                                                    .toString() ??
                                                "-",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  );
                }
            }
          },
        ),
      ),
    );
  }
}

class Html {}
