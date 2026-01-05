import 'package:flutter/material.dart';
import '../models/gift_card.dart';
import '../services/mock_data_service.dart';

class CoinsProvider with ChangeNotifier {
  final MockDataService _service = MockDataService();

  int _balance = 0;
  List<GiftCardOption> _catalog = [];
  List<RedeemedGiftCard> _myGiftCards = [];
  
  bool _isLoading = false;
  String? _error;

  int get balance => _balance;
  List<GiftCardOption> get catalog => _catalog;
  List<RedeemedGiftCard> get myGiftCards => _myGiftCards;
  bool get isLoading => _isLoading;
  String? get error => _error;

  CoinsProvider() {
    _initData();
  }

  Future<void> _initData() async {
    _isLoading = true;
    notifyListeners();
    try {
      _balance = await _service.getUserBalance();
      _catalog = await _service.getCatalog();
    } catch (e) {
      _error = "Error cargando datos: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> redeemGiftCard(GiftCardOption option) async {
    if (_balance < option.costCoins) {
      _error = "Saldo insuficiente";
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _error = null; // Clear previous errors
    notifyListeners();

    try {
      final redeemed = await _service.redeemCoin(option);
      _balance -= option.costCoins;
      _myGiftCards.insert(0, redeemed); // Add to top of list
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = "Error en el canje: $e";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
