import 'package:cryptotrack/models/cripto_currency.dart';
import 'package:cryptotrack/pages/details_page.dart';
import 'package:cryptotrack/providers/market_provider.dart';
import 'package:cryptotrack/widgets/crypto_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Markets extends StatefulWidget {
  Markets({Key? key}) : super(key: key);

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        if (marketProvider.isLoading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (marketProvider.markets.isNotEmpty) {
            //? fetch data manully by RefreshIndicator.
            return RefreshIndicator(
              onRefresh: () async {
                await marketProvider.fetchData();
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: marketProvider.markets.length,
                itemBuilder: (context, index) {
                  //todo: markets_provider.dart > pass data details_page.dart/ initiate the data/ 2
                  CryptroCurrency currentCrypto = marketProvider.markets[index];

                  return CryptoListTile(currentCrypto: currentCrypto);
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
    );
  }
}
