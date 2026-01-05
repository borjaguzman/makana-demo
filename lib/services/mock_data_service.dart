import 'dart:async';
import 'dart:math';
import '../models/gift_card.dart';

class MockDataService {
  // Simulate network delay
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 1500)); // 1.5 second delay for animation visibility
  }

  Future<int> getUserBalance() async {
    await _simulateDelay();
    return 8500; // Starting Balance
  }

  Future<List<GiftCardOption>> getCatalog() async {
    await _simulateDelay();
    return [
      GiftCardOption(id: '1', storeName: 'Unimarc', amountClp: 5000, costCoins: 2500, imageUrl: 'assets/unimarc.png'),
      GiftCardOption(id: '2', storeName: 'Unimarc', amountClp: 10000, costCoins: 5000, imageUrl: 'assets/unimarc.png'),
      GiftCardOption(id: '3', storeName: 'Paris', amountClp: 5000, costCoins: 2500, imageUrl: 'assets/paris.png'),
      GiftCardOption(id: '4', storeName: 'Paris', amountClp: 10000, costCoins: 5000, imageUrl: 'assets/paris.png'),
      GiftCardOption(id: '5', storeName: 'Falabella', amountClp: 20000, costCoins: 10000, imageUrl: 'assets/falabella.png'),
      GiftCardOption(id: '6', storeName: 'Hugo Boss', amountClp: 50000, costCoins: 25000, imageUrl: 'assets/hugoboss.png'),
    ];
  }

  Future<RedeemedGiftCard> redeemCoin(GiftCardOption option) async {
    await _simulateDelay();
    
    // Simulate randomness for error testing? For now, always success.
    final code = "MOCK-${Random().nextInt(99999).toString().padLeft(5, '0')}-${option.storeName.substring(0,3).toUpperCase()}";
    
    return RedeemedGiftCard(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      option: option,
      code: code,
      dateRedeemed: DateTime.now(),
    );
  }
}
