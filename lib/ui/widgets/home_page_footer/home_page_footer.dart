import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app1/domain/provider/weather_provider.dart';
import 'package:weather_app1/ui/theme/app_colors.dart';
import 'package:weather_app1/ui/widgets/home_page_box/home_page_box.dart';

class HomePageFooter extends StatelessWidget {
  const HomePageFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);

    return HomePageBox(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FooterItem(
              value: 'Восход ${model.setCurrentSunRice()}',
            ),
            FooterItem(
              value: 'Закат ${model.setCurrentSunset()}',
            ),
          ],
        ),
      ),
    );
  }
}

class FooterItem extends StatelessWidget {
  final String value;
  const FooterItem({
    super.key,
    this.value = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/icons/sunrise.svg',
          color: AppColors.primaryColor,
        ),
        const SizedBox(height: 18),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            height: 22 / 16,
            color: AppColors.secondaryColor,
          ),
        ),
      ],
    );
  }
}
