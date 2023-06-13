import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app1/domain/provider/weather_provider.dart';
import 'package:weather_app1/ui/app_navigator/app_routes.dart';
import 'package:weather_app1/ui/theme/app_colors.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);

    final getCity = model.setCurrentCity().split('/');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 48),
        Column(
          children: [
            TextButton.icon(
              onPressed: null,
              icon: SvgPicture.asset('assets/icons/location.svg'),
              label: Text(
                getCity[1],
                style: TextStyle(
                  fontSize: 20,
                  height: 22 / 20,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            Text(
              '${model.setCurrentDay()} 15:00 АМ',
              style: TextStyle(
                fontSize: 14,
                height: 22 / 14,
                color: AppColors.primaryColor,
              ),
            )
          ],
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.search);
          },
          color: AppColors.primaryColor,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
