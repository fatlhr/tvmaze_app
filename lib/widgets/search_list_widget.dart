import 'package:flutter/material.dart';

class SearchListWidget extends StatelessWidget {
  const SearchListWidget({
    Key? key,
    required this.snapshot,
  }) : super(key: key);
  final AsyncSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemExtent: MediaQuery.of(context).size.height / 4,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        String? image = snapshot.data![index].theShow?.image?.medium;
        String? summary;
        if (snapshot.data![index].theShow?.summary != null) {
          summary = snapshot.data![index].theShow?.summary!
              .replaceAll("<p>", "")
              .replaceAll("<b>", "")
              .replaceAll("</b>", "")
              .replaceAll("<i", "")
              .replaceAll("</i>", "");
        }
        return Card(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: MediaQuery.of(context).size.width / 3,
                  child: image != null
                      ? Image.network(
                          snapshot.data![index].theShow!.image!.medium ?? "",
                          fit: BoxFit.cover,
                        )
                      : const Center(child: Text("No Image")),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data![index].theShow?.name ?? "",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          snapshot.data![index].theShow?.premiered ?? "-",
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          summary ?? "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
