import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'providers/coins_provider.dart';
import 'screens/home_entry_mock.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final storageService = StorageService();
  await storageService.init();
  
  runApp(MakanaDemoApp(storageService: storageService));
}

class MakanaDemoApp extends StatelessWidget {
  final StorageService storageService;

  const MakanaDemoApp({
    Key? key,
    required this.storageService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CoinsProvider(storageService)),
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
