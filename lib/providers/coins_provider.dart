import 'package:flutter/material.dart';
import '../models/gift_card.dart';
import '../models/transaction.dart';
import '../services/mock_data_service.dart';
import '../services/storage_service.dart';

class CoinsProvider with ChangeNotifier {
  final MockDataService _service = MockDataService();
  final StorageService _storage;

  int _balance = 0;
  List<GiftCardOption> _catalog = [];
  List<RedeemedGiftCard> _myGiftCards = [];
  List<Transaction> _transactions = [];
  
  bool _isLoading = false;
  String? _error;
  
  // Search and filter state
  String _searchQuery = '';
  Set<String> _selectedTypes = {};
  PriceRange? _selectedPriceRange;

  int get balance => _balance;
  List<GiftCardOption> get catalog => _catalog;
  List<RedeemedGiftCard> get myGiftCards => _myGiftCards;
  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  Set<String> get selectedTypes => _selectedTypes;
  PriceRange? get selectedPriceRange => _selectedPriceRange;
  
  // Filtered catalog based on search and filters
  List<GiftCardOption> get filteredCatalog {
    var filtered = _catalog;
    
    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((option) {
        return option.storeName.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
    
    // Apply type filter
    if (_selectedTypes.isNotEmpty) {
      filtered = filtered.where((option) {
        return _selectedTypes.contains(option.type);
      }).toList();
    }
    
    // Apply price filter
    if (_selectedPriceRange != null) {
      filtered = filtered.where((option) {
        switch (_selectedPriceRange!) {
          case PriceRange.low:
            return option.costCoins <= 5000;
          case PriceRange.medium:
            return option.costCoins > 5000 && option.costCoins <= 10000;
          case PriceRange.high:
            return option.costCoins > 10000;
        }
      }).toList();
    }
    
    return filtered;
  }
  
  // Get unique types for filter chips
  List<String> get availableTypes {
    return _catalog.map((option) => option.type).toSet().toList()..sort();
  }

  CoinsProvider(this._storage) {
    _initData();
  }

  Future<void> _initData() async {
    // 1. Load from cache immediately
    _balance = _storage.getBalance();
    _myGiftCards = _storage.getGiftCards();
    _isLoading = true;
    notifyListeners();

    // 2. Fetch from network
    try {
      final serverBalance = await _service.getUserBalance();
      final serverCatalog = await _service.getCatalog();
      _transactions = await _service.getTransactionHistory();
      
      // 3. Update state and cache
      _balance = serverBalance;
      _catalog = serverCatalog;
      await _storage.saveBalance(_balance);
      
    } catch (e) {
      _error = "Error cargando datos: $e";
      // On error, we still have cached data shown
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
      
      // Save changes to storage
      await _storage.saveBalance(_balance);
      await _storage.saveGiftCard(redeemed);
      
      // Add transaction record
      _transactions.insert(0, Transaction(
        id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
        type: TransactionType.spent,
        amount: option.costCoins,
        description: 'Canje ${option.storeName} - ${option.amountClp}',
        date: DateTime.now(),
        status: TransactionStatus.completed,
        relatedGiftCardId: redeemed.id,
      ));
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
  
  // Search and filter methods
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
  
  void toggleTypeFilter(String type) {
    if (_selectedTypes.contains(type)) {
      _selectedTypes.remove(type);
    } else {
      _selectedTypes.add(type);
    }
    notifyListeners();
  }
  
  void setPriceFilter(PriceRange? range) {
    // Toggle check
    if (_selectedPriceRange == range) {
      _selectedPriceRange = null;
    } else {
      _selectedPriceRange = range;
    }
    notifyListeners();
  }
  
  void clearFilters() {
    _searchQuery = '';
    _selectedTypes.clear();
    _selectedPriceRange = null;
    notifyListeners();
  }
}

enum PriceRange {
  low,    // <= 5000
  medium, // 5001 - 10000
  high    // > 10000
}
