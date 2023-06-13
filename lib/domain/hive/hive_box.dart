import 'package:hive/hive.dart';
import 'package:weather_app1/domain/hive/favorite_model.dart';

class HiveBox {
  static const String hiveKey = '__FAV__';
  static Box<FavoriteModel> favoriteBox = Hive.box<FavoriteModel>(hiveKey);
}
