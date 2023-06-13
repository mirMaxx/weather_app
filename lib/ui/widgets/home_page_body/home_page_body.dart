import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app1/domain/provider/weather_provider.dart';
import 'package:weather_app1/ui/theme/app_colors.dart';
import 'package:weather_app1/ui/widgets/home_page_box/home_page_box.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    return HomePageBox(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => DailyItem(
          day: model.setDailyDay(index),
          dayTemp: model.setdailyDayTemp(index),
          nightTemp: model.setdailyNightTemp(index),
          index: index,
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: 8,
      ),
    );
  }
}

class DailyItem extends StatelessWidget {
  final String day;
  final int dayTemp;
  final int nightTemp;
  final int index;
  const DailyItem({
    super.key,
    this.day = '',
    this.dayTemp = 0,
    this.nightTemp = 0,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    TextStyle textStyle = TextStyle(
      fontSize: 20,
      height: 22 / 20,
      color: AppColors.primaryColor,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            day,
            style: textStyle,
          ),
        ),
        Image.network(
          model.setDailyIcons(index),
          width: 30,
          height: 30,
          color: AppColors.primaryColor,
        ),
        SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$dayTemp℃',
                style: textStyle,
              ),
              Text(
                '$nightTemp℃',
                style: textStyle.copyWith(
                  color: AppColors.secondaryColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
