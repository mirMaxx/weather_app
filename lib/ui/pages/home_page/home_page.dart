import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app1/domain/provider/weather_provider.dart';
import 'package:weather_app1/ui/widgets/home_page_app_bar/home_page_app_bar.dart';
import 'package:weather_app1/ui/widgets/home_page_body/body_block.dart';
import 'package:weather_app1/ui/widgets/home_page_body/home_page_body.dart';
import 'package:weather_app1/ui/widgets/home_page_footer/home_page_footer.dart';
import 'package:weather_app1/ui/widgets/home_page_header/home_page_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildBody(
      BuildContext context,
      AsyncSnapshot snapshot,
    ) {
      switch (snapshot.connectionState) {
        case ConnectionState.done:
          return const HomePageContent();
        case ConnectionState.waiting:
        default:
          return const Center(
            child: CircularProgressIndicator(),
          );
      }
    }

    return Scaffold(
      body: FutureBuilder(
        future: context.read<WeatherProvider>().setUp(),
        builder: buildBody,
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    return Ink(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(model.setWeatherTheme()),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const HomePageAppBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  HomePageHeader(),
                  SizedBox(height: 30),
                  HomePageBody(),
                  SizedBox(height: 30),
                  BodyBlock(),
                  SizedBox(height: 30),
                  HomePageFooter(),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
