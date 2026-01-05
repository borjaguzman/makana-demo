import 'dart:async';
import 'dart:math';
import '../models/gift_card.dart';
import '../models/transaction.dart';

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
  // Supermercado
  GiftCardOption(
    id: '1',
    storeName: 'Unimarc',
    amountClp: 5000,
    costCoins: 2500,
    imageUrl: 'assets/unimarc.png',
    type: 'supermercado',
  ),
  GiftCardOption(
    id: '2',
    storeName: 'Unimarc',
    amountClp: 10000,
    costCoins: 5000,
    imageUrl: 'assets/unimarc.png',
    type: 'supermercado',
  ),
  GiftCardOption(
    id: '3',
    storeName: 'Lider',
    amountClp: 10000,
    costCoins: 5000,
    imageUrl: 'assets/lider.png',
    type: 'supermercado',
  ),
  GiftCardOption(
    id: '4',
    storeName: 'Jumbo',
    amountClp: 20000,
    costCoins: 10000,
    imageUrl: 'assets/jumbo.png',
    type: 'supermercado',
  ),

  // Retail / Ropa
  GiftCardOption(
    id: '5',
    storeName: 'Paris',
    amountClp: 5000,
    costCoins: 2500,
    imageUrl: 'assets/paris.png',
    type: 'ropa',
  ),
  GiftCardOption(
    id: '6',
    storeName: 'Paris',
    amountClp: 10000,
    costCoins: 5000,
    imageUrl: 'assets/paris.png',
    type: 'ropa',
  ),
  GiftCardOption(
    id: '7',
    storeName: 'Falabella',
    amountClp: 20000,
    costCoins: 10000,
    imageUrl: 'assets/falabella.png',
    type: 'ropa',
  ),
  GiftCardOption(
    id: '8',
    storeName: 'H&M',
    amountClp: 15000,
    costCoins: 7500,
    imageUrl: 'assets/hm.png',
    type: 'ropa',
  ),
  GiftCardOption(
    id: '9',
    storeName: 'Hugo Boss',
    amountClp: 50000,
    costCoins: 25000,
    imageUrl: 'assets/hugoboss.png',
    type: 'ropa',
  ),

  // Comida
  GiftCardOption(
    id: '10',
    storeName: 'McDonald\'s',
    amountClp: 5000,
    costCoins: 2500,
    imageUrl: 'assets/mcdonalds.png',
    type: 'comida',
  ),
  GiftCardOption(
    id: '11',
    storeName: 'Burger King',
    amountClp: 8000,
    costCoins: 4000,
    imageUrl: 'assets/burgerking.png',
    type: 'comida',
  ),
  GiftCardOption(
    id: '12',
    storeName: 'Starbucks',
    amountClp: 10000,
    costCoins: 5000,
    imageUrl: 'assets/starbucks.png',
    type: 'comida',
  ),

  // Entretenimiento
  GiftCardOption(
    id: '13',
    storeName: 'Netflix',
    amountClp: 10000,
    costCoins: 5000,
    imageUrl: 'assets/netflix.png',
    type: 'entretenimiento',
  ),
  GiftCardOption(
    id: '14',
    storeName: 'Spotify',
    amountClp: 8000,
    costCoins: 4000,
    imageUrl: 'assets/spotify.png',
    type: 'entretenimiento',
  ),
  GiftCardOption(
    id: '15',
    storeName: 'Cinepolis',
    amountClp: 12000,
    costCoins: 6000,
    imageUrl: 'assets/cinepolis.png',
    type: 'entretenimiento',
  ),

  // Tecnología
  GiftCardOption(
    id: '16',
    storeName: 'PC Factory',
    amountClp: 20000,
    costCoins: 10000,
    imageUrl: 'assets/pcfactory.png',
    type: 'tecnologia',
  ),
  GiftCardOption(
    id: '17',
    storeName: 'Apple Store',
    amountClp: 25000,
    costCoins: 12500,
    imageUrl: 'assets/apple.png',
    type: 'tecnologia',
  ),

  // Transporte
  GiftCardOption(
    id: '18',
    storeName: 'Uber',
    amountClp: 10000,
    costCoins: 5000,
    imageUrl: 'assets/uber.png',
    type: 'transporte',
  ),
  GiftCardOption(
    id: '19',
    storeName: 'Cabify',
    amountClp: 15000,
    costCoins: 7500,
    imageUrl: 'assets/cabify.png',
    type: 'transporte',
  ),
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
  
  Future<List<Transaction>> getTransactionHistory() async {
    await _simulateDelay();
    
    final now = DateTime.now();
    
    return [
      Transaction(
        id: 'txn_1',
        type: TransactionType.earned,
        amount: 500,
        description: 'Completaste rutina de seguridad',
        date: now.subtract(const Duration(days: 1)),
        status: TransactionStatus.completed,
      ),
      Transaction(
        id: 'txn_2',
        type: TransactionType.earned,
        amount: 300,
        description: 'Asistencia perfecta',
        date: now.subtract(const Duration(days: 3)),
        status: TransactionStatus.completed,
      ),
      Transaction(
        id: 'txn_3',
        type: TransactionType.earned,
        amount: 1000,
        description: 'Bonificación mensual',
        date: now.subtract(const Duration(days: 7)),
        status: TransactionStatus.completed,
      ),
      Transaction(
        id: 'txn_4',
        type: TransactionType.spent,
        amount: 2500,
        description: 'Canje Unimarc - \$5.000',
        date: now.subtract(const Duration(days: 10)),
        status: TransactionStatus.completed,
      ),
      Transaction(
        id: 'txn_5',
        type: TransactionType.earned,
        amount: 750,
        description: 'Reporte de calidad aprobado',
        date: now.subtract(const Duration(days: 14)),
        status: TransactionStatus.completed,
      ),
    ];
  }
}
