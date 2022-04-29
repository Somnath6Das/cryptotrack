import 'package:cryptotrack/pages/details_page.dart';
import 'package:cryptotrack/providers/market_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cryptotrack/models/cripto_currency.dart';
import 'package:provider/provider.dart';

class CryptoListTile extends StatelessWidget {
  final CryptroCurrency currentCrypto;

  const CryptoListTile({Key? key, required this.currentCrypto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MarketProvider marketProvider =
        Provider.of<MarketProvider>(context, listen: false);
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                //todo: markets_provider.dart > data pass through details_page.dart/ 3
                builder: (context) => DetailsPage(
                      id: currentCrypto.id!,
                    )));
      },
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(currentCrypto.image!),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              currentCrypto.name!,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 16),
          //todo: isFavorite false then add to favorite otherwise it will remove from favorite.

          (currentCrypto.isFavorite == false)
              ? GestureDetector(
                  onTap: () {
                    marketProvider.addFavorite(currentCrypto);
                  },
                  child: const Icon(
                    CupertinoIcons.star,
                    color: Colors.amber,
                    size: 18,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    marketProvider.removedFavorite(currentCrypto);
                  },
                  child: const Icon(
                    CupertinoIcons.star_fill,
                    color: Colors.amber,
                    size: 18,
                  ),
                )
        ],
      ),
      subtitle: Text(currentCrypto.symbol!.toUpperCase()),

      //? Right side information
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "₹ " + currentCrypto.currentPrice!.toStringAsFixed(4),
            style: const TextStyle(
                color: Color(0xff0395eb),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          Builder(builder: (context) {
            double priceChange = currentCrypto.priceChange24!;
            double priceChangePercentage =
                currentCrypto.priceChangePercentage24!;
            if (priceChange < 0) {
              //? negative
              return Text(
                "${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(3)})",
                style: const TextStyle(color: Colors.red),
              );
            } else {
              //? positive
              return Text(
                "+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(3)})",
                style: const TextStyle(color: Colors.green),
              );
            }
          })
        ],
      ),
    );
  }
}
