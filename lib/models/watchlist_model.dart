import 'package:hive/hive.dart';

part 'watchlist_model.g.dart';

@HiveType(typeId: 0)
class Watchlist extends HiveObject {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late String title;
  @HiveField(2)
  late String summary;
  @HiveField(3)
  late String image;
}

