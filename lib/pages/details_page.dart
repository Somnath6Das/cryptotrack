import 'package:cryptotrack/models/cripto_currency.dart';
import 'package:cryptotrack/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  //todo: markets.dart > declear datatype/ 4
  final String id;
  //todo: markets.dart > create constructor / 5
  DetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Widget titleAndDetails(
      String title, String details, CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        Text(
          details,
          style: const TextStyle(fontSize: 17),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Consumer<MarketProvider>(
          builder: (context, marketProvider, child) {
            //todo: markets.dart > make a intance of cryptrocurrency / 6
            CryptroCurrency cryptroCurrency =
                marketProvider.fetchCryptoById(widget.id);
                
            //? fetch data manully by RefreshIndicator.
            return RefreshIndicator(
              onRefresh: () async {
                await marketProvider.fetchData();
              },
              child: ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(cryptroCurrency.image!),
                    ),
                    title: Text(
                      cryptroCurrency.name! +
                          "(${cryptroCurrency.symbol!.toUpperCase()})",
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      "₹" + cryptroCurrency.currentPrice!.toStringAsFixed(4),
                      style: const TextStyle(
                          color: Color(0xff0395eb),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Price Change (24 hr)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Builder(builder: (context) {
                        double priceChange = cryptroCurrency.priceChange24!;
                        double priceChangePercentage =
                            cryptroCurrency.priceChangePercentage24!;
                        if (priceChange < 0) {
                          //negative
                          return Text(
                            "${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(3)})",
                            style: const TextStyle(
                                color: Colors.red, fontSize: 23),
                          );
                        } else {
                          //positive
                          return Text(
                            "+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(3)})",
                            style: const TextStyle(
                                color: Colors.green, fontSize: 23),
                          );
                        }
                      })
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetails(
                          "Market Cap",
                          "₹ " + cryptroCurrency.marketCap!.toStringAsFixed(4),
                          CrossAxisAlignment.start),
                      titleAndDetails(
                          "Market Cap Rank",
                          "₹ " + cryptroCurrency.marketCapRank!.toString(),
                          CrossAxisAlignment.end)
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetails(
                          "Low 24h",
                          "₹ " + cryptroCurrency.low24!.toStringAsFixed(4),
                          CrossAxisAlignment.start),
                      titleAndDetails(
                          "High 24h",
                          "₹ " + cryptroCurrency.high24!.toStringAsFixed(4),
                          CrossAxisAlignment.end)
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetails(
                          "Circulating Supply",
                          cryptroCurrency.circulatingSupply.toString(),
                          CrossAxisAlignment.start),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetails(
                          "All Time Low",
                          cryptroCurrency.atl!.toStringAsFixed(4),
                          CrossAxisAlignment.start),
                      titleAndDetails(
                          "All Time High",
                          cryptroCurrency.ath!.toStringAsFixed(4),
                          CrossAxisAlignment.end),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      )),
    );
  }
}
