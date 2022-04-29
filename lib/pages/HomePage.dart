import 'package:cryptotrack/constants/themes.dart';
import 'package:cryptotrack/models/cripto_currency.dart';
import 'package:cryptotrack/pages/details_page.dart';
import 'package:cryptotrack/pages/favorites.dart';
import 'package:cryptotrack/pages/markets.dart';
import 'package:cryptotrack/providers/market_provider.dart';
import 'package:cryptotrack/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

//? extend with TickerProviderStateMixin for for tab bar.
class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController viewController;

  @override
  void initState() {
    super.initState();
    viewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 0),

        //Top heading
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome Back",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Crypto Today",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      //! theme change button *6
                      themeProvider.toggleTheme();
                    },
                    padding: const EdgeInsets.all(0),
                    icon: (themeProvider.themeMode == ThemeMode.light)
                        ? const Icon(Icons.dark_mode)
                        : const Icon(Icons.light_mode,color: Colors.amber,))
              ],
            ),
            const SizedBox(height: 20),
            TabBar(
                //? Tab bar and Tab bar view always need controller.
                controller: viewController,
                tabs: [
                  Tab(
                    child: Text(
                      "Markets",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Favorites",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ]),
            Expanded(
              //? tab bar view do not give any space to give space rap with expended
              child: TabBarView(
                  //? TabBar tabs have to equal with TabBarView children.
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  controller: viewController,
                  children: [Markets(), Favorites()]),
            )
          ],
        ),
      )),
    );
  }
}
