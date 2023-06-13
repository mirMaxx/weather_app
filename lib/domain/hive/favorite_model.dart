import 'package:hive/hive.dart';

part 'favorite_model.g.dart';


@HiveType(typeId: 0)
class FavoriteModel {
  @HiveField(0)
  final String bg;
  @HiveField(1)
  final String city;
  @HiveField(2)
  final int color;

  FavoriteModel({
    required this.bg,
    required this.city,
    required this.color,
  });
}
