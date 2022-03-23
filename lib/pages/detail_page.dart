import 'package:flutter/material.dart';

import '../models/detail_show_model.dart';
import '../services/all_services.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<DetailShow>(
          future: AllServices.getDetail(widget.id.toString()),
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
                  return Text(snapshot.data?.name ?? 'No Title');
                }
            }
          },
        ),
      ),
    );
  }
}
