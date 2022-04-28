import 'package:cryptotrack/constants/themes.dart';
import 'package:cryptotrack/models/cripto_currency.dart';
import 'package:cryptotrack/pages/details_page.dart';
import 'package:cryptotrack/providers/market_provider.dart';
import 'package:cryptotrack/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                        : const Icon(Icons.light_mode))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(child: Consumer<MarketProvider>(
              builder: (context, marketProvider, child) {
                if (marketProvider.isLoading == true) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (marketProvider.markets.isNotEmpty) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        await marketProvider.fetchData();
                      },
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: marketProvider.markets.length,
                        itemBuilder: (context, index) {
                          //todo: pass data details page/ initiate the data/ 2
                          CryptroCurrency currentCrypto =
                              marketProvider.markets[index];

                          //left side information
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      //todo: data pass through details page/ 3
                                      builder: (context) => DetailsPage(
                                            id: currentCrypto.id!,
                                          )));
                            },
                            contentPadding: const EdgeInsets.all(0),
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  NetworkImage(currentCrypto.image!),
                            ),
                            title: Text(currentCrypto.name! +
                                "  #${currentCrypto.marketCapRank}"),
                            subtitle: Text(currentCrypto.symbol!.toUpperCase()),

                            //Right side information
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "₹ " +
                                      currentCrypto.currentPrice!
                                          .toStringAsFixed(4),
                                  style: const TextStyle(
                                      color: Color(0xff0395eb),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Builder(builder: (context) {
                                  double priceChange =
                                      currentCrypto.priceChange24!;
                                  double priceChangePercentage =
                                      currentCrypto.priceChangePercentage24!;
                                  if (priceChange < 0) {
                                    //negative
                                    return Text(
                                      "${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(3)})",
                                      style: const TextStyle(color: Colors.red),
                                    );
                                  } else {
                                    //positive
                                    return Text(
                                      "+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(3)})",
                                      style:
                                          const TextStyle(color: Colors.green),
                                    );
                                  }
                                })
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              },
            ))
          ],
        ),
      )),
    );
  }
}
