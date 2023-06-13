import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app1/domain/provider/weather_provider.dart';
import 'package:weather_app1/ui/theme/app_colors.dart';
import 'package:weather_app1/ui/widgets/home_page_box/home_page_box.dart';

class BodyBlock extends StatelessWidget {
  const BodyBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    return GridView.builder(
      shrinkWrap: true,
      itemBuilder: (context, i) => BodyBlockItem(
        subTitle: BodyBlockItemUnits.subTitles[i],
        icon: BodyBlockItemUnits.icons[i],
        units: BodyBlockItemValues.values[i],
        value: model.setValues(i),
      ),
      itemCount: 4,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 181,
        mainAxisExtent: 160,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
    );
  }
}

class BodyBlockItem extends StatelessWidget {
  final String subTitle;
  final String icon;
  final double value;
  final BodyBlockItemValues? units;
  const BodyBlockItem({
    super.key,
    this.subTitle = '',
    this.value = 0,
    this.icon = 'assets/icons/visibility.svg',
    this.units,
  });

  @override
  Widget build(BuildContext context) {
    final unit =
        BodyBlockItemTreatment.unitsTreatment(units ?? BodyBlockItemValues.deg);
    return HomePageBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 6),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$value $unit',
                style: TextStyle(
                  fontSize: 14,
                  height: 22 / 14,
                  color: AppColors.secondaryColor,
                ),
              ),
              Text(
                subTitle,
                style: TextStyle(
                  fontSize: 10,
                  height: 22 / 10,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BodyBlockItemUnits {
  static List<String> subTitles = [
    'Скорость ветра',
    'Ощущается',
    'Влажность',
    'Видимость',
  ];

  static List<String> icons = [
    'assets/icons/wind_speed.svg',
    'assets/icons/feels_like.svg',
    'assets/icons/Hummidity.svg',
    'assets/icons/visibility.svg',
  ];
}

enum BodyBlockItemValues { kmh, deg, percent, km }

class BodyBlockItemTreatment {
  static String unitsTreatment(BodyBlockItemValues values) {
    switch (values) {
      case BodyBlockItemValues.deg:
        return '°';
      case BodyBlockItemValues.km:
        return 'км';
      case BodyBlockItemValues.kmh:
        return 'км/ч';
      default:
        return '%';
    }
  }
}
