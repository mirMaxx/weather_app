import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:weather_app1/domain/hive/hive_box.dart';
import 'package:weather_app1/domain/provider/weather_provider.dart';
import 'package:weather_app1/ui/theme/app_colors.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD8E8F0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SearchPageAppBar(),
              SizedBox(height: 28),
              CurrentRegionCard(),
              SizedBox(height: 16),
              Text(
                'Избранное',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff323232),
                  fontWeight: FontWeight.bold,
                ),
              ),
              FavoriteList(),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteList extends StatelessWidget {
  const FavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: HiveBox.favoriteBox.listenable(),
        builder: (context, value, _) {
          final favList = value.values.toList();
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemBuilder: (context, index) => FavoriteItem(
              bg: favList[index].bg,
              color: favList[index].color,
              city: favList[index].city,
              index: index,
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemCount: favList.length,
          );
        },
      ),
    );
  }
}

class FavoriteItem extends StatelessWidget {
  final String bg;
  final String city;
  final int color;
  final int index;
  const FavoriteItem(
      {super.key,
      required this.bg,
      required this.city,
      required this.color,
      required this.index});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            bg,
          ),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Избранное',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(color),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                city,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 9),
              Text(
                city,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          IconButton(
            color: Colors.red,
            onPressed: () {
              model.removeFavorite(index);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}

class SearchPageAppBar extends StatelessWidget {
  const SearchPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    const OutlineInputBorder borderDecoration = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(4)),
    );
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        Expanded(
          child: TextField(
            controller: model.cityController,
            decoration: const InputDecoration(
              border: borderDecoration,
              enabledBorder: borderDecoration,
              focusedBorder: borderDecoration,
              fillColor: Color.fromRGBO(109, 160, 192, .13),
              filled: true,
              hintText: 'Введите город/регион',
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 2,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            model.searchCity(context);
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }
}

class CurrentRegionCard extends StatelessWidget {
  const CurrentRegionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    final getCity = model.setCurrentCity().split('/');
    return Container(
      constraints: const BoxConstraints(maxHeight: 96),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(model.setWeatherTheme()),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Column(
            children: [
              const Text('Текущее место'),
              Text('$getCity'),
              Text('${model.currentCity}'),
            ],
          ),
          Row(),
        ],
      ),
    );
  }
}
