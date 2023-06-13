import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app1/domain/provider/weather_provider.dart';
import 'package:weather_app1/ui/theme/app_colors.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    return Column(
      children: [
        const SizedBox(height: 32),
        const HeaderStatus(),
        const SizedBox(height: 32),
        GestureDetector(
          onDoubleTap: () {
            model.addFavorite();
          },
          child: const HeaderCurrentTemp(),
        ),
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            HeaderMinMax.max(value: 13),
            SizedBox(width: 65),
            HeaderMinMax.min(value: 6),
          ],
        )
      ],
    );
  }
}

class HeaderStatus extends StatelessWidget {
  const HeaderStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(model.setCurrentIcon()),
        const SizedBox(width: 25),
        Text(
          model.setCurrentWeatherStatus(),
          style: TextStyle(
            fontSize: 16,
            height: 22 / 16,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}

class HeaderCurrentTemp extends StatelessWidget {
  const HeaderCurrentTemp({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    return Text(
      '${model.setCurrentTemp()}°',
      style: TextStyle(
        fontSize: 90,
        color: AppColors.primaryColor,
      ),
    );
  }
}

class HeaderMinMax extends StatelessWidget {
  final int value;
  final String icon;

  const HeaderMinMax.min({super.key, required this.value})
      : icon = 'assets/icons/min.svg';
  const HeaderMinMax.max({super.key, required this.value})
      : icon = 'assets/icons/max.svg';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        const SizedBox(width: 4),
        Text(
          '$value°',
          style: TextStyle(
            fontSize: 25,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
