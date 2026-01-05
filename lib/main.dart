import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'providers/coins_provider.dart';
import 'screens/home_entry_mock.dart';

void main() {
  runApp(const MakanaDemoApp());
}

class MakanaDemoApp extends StatelessWidget {
  const MakanaDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CoinsProvider()),
      ],
      child: MaterialApp(
        title: 'Makana Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const HomeEntryMock(),
      ),
    );
  }
}
