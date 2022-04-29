import 'package:cryptotrack/models/cripto_currency.dart';
import 'package:cryptotrack/providers/market_provider.dart';
import 'package:cryptotrack/widgets/crypto_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(builder: (context, MarketProvider, child) {
      //todo: pick the isFavorite true value from MarketProvider
      List<CryptroCurrency> favorites = MarketProvider.markets
          .where((element) => element.isFavorite == true)
          .toList();

      if (favorites.length > 0) { 
        //todo: to show favorite list
        return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              CryptroCurrency currentCrypto = favorites[index];
              return CryptoListTile(currentCrypto: currentCrypto);
            });
      } else {
        return const Center(
          child: Text("No favorite yet ",style: TextStyle(color: Colors.grey,fontSize: 20),)
        );
      }
    }

       

        );
  }
}
