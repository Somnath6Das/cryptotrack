import 'package:cryptotrack/constants/themes.dart';
import 'package:cryptotrack/pages/HomePage.dart';
import 'package:cryptotrack/providers/market_provider.dart';
import 'package:cryptotrack/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketProvider>(
            create: (context) => MarketProvider()),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        )
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
