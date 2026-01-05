class GiftCardOption {
  final String id;
  final String storeName;
  final int amountClp;
  final int costCoins;
  final String imageUrl;
  final String type; // Placeholder for store logo

  GiftCardOption({
    required this.id,
    required this.storeName,
    required this.amountClp,
    required this.costCoins,
    required this.imageUrl,
    required this.type,
  });
}

class RedeemedGiftCard {
  final String id;
  final GiftCardOption option;
  final String code;
  final DateTime dateRedeemed;

  RedeemedGiftCard({
    required this.id,
    required this.option,
    required this.code,
    required this.dateRedeemed,
  });
}
