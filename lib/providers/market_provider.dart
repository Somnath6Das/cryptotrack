import 'dart:async';

import 'package:cryptotrack/models/api.dart';
import 'package:cryptotrack/models/cripto_currency.dart';
import 'package:flutter/cupertino.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<CryptroCurrency> markets = [];

  MarketProvider() {
    fetchData();
  }

  Future <void> fetchData() async {
    List<dynamic> _markets = await API.getMarkets();

    List<CryptroCurrency> temp = [];

    for (var market in _markets) {
      CryptroCurrency newCrypto = CryptroCurrency.fromJson(market);
      temp.add(newCrypto);
    }

    markets = temp;
    isLoading = false;
    notifyListeners();

    
    
    //auto fetch api data every after 3 seconds
    // Timer(const Duration(seconds: 15), () {
    //   fetchData();
    //   print("Data Update");
    // });
  }

  //todo: fetch data by id for details page / 1
  CryptroCurrency fetchCryptoById(String id) {
    CryptroCurrency crypto =
        markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }
}
