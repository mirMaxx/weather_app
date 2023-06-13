import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:weather_app1/domain/hive/favorite_model.dart';
import 'package:weather_app1/domain/hive/hive_box.dart';
import 'package:weather_app1/ui/app.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteModelAdapter());
  await Hive.openBox<FavoriteModel>(HiveBox.hiveKey);
  
  runApp(const MyApp());
}
