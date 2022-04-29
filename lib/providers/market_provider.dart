import 'dart:async';
import 'package:cryptotrack/models/api.dart';
import 'package:cryptotrack/models/cripto_currency.dart';
import 'package:cryptotrack/models/local_storage.dart';
import 'package:flutter/cupertino.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<CryptroCurrency> markets = [];

  MarketProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    List<dynamic> _markets = await API.getMarkets();
    List<CryptroCurrency> temp = [];

    //todo: local_storage.dart > create local storage data to favorite list
    List<String> favorites = await LocalStorage.fetchFavorites();

    for (var market in _markets) {
      CryptroCurrency newCrypto = CryptroCurrency.fromJson(market);
      temp.add(newCrypto);

      //todo: cheque favorite id match with newCrypto via for loop.
      if (favorites.contains(newCrypto.id!)) {
        newCrypto.isFavorite = true;
      }
    }

    markets = temp;
    isLoading = false;
    notifyListeners();

    //? auto fetch api data every after 30 seconds. you can change seconds.
    Timer(const Duration(seconds: 30), () {
      fetchData();
      print("Data Update");
    });
  }

  //todo: fetch data by id to pass deta to > markets.dart > details_page.dart
  CryptroCurrency fetchCryptoById(String id) {
    CryptroCurrency crypto =
        markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }

  //todo: if favorite match with market then this function
  void addFavorite(CryptroCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavorite = true;
    await LocalStorage.addFavorite(crypto.id!);
    notifyListeners();
  }

  void removedFavorite(CryptroCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavorite = false;
    await LocalStorage.removeFavorite(crypto.id!);
    notifyListeners();
  }
}
