import 'package:cryptotrack/constants/themes.dart';
import 'package:cryptotrack/models/local_storage.dart';
import 'package:cryptotrack/pages/HomePage.dart';
import 'package:cryptotrack/providers/market_provider.dart';
import 'package:cryptotrack/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //   ?? means if it is null the after ?? function will run.
  String currentTheme = await LocalStorage.getTheme() ?? "light";
  runApp(MyApp(
    theme: currentTheme,
  ));
}

class MyApp extends StatelessWidget {
  final String theme;
  MyApp({required this.theme});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketProvider>(
            create: (context) => MarketProvider()),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(theme),
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
