import 'package:hive/hive.dart';

part 'gift_card.g.dart';

@HiveType(typeId: 0)
class GiftCardOption extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String storeName;
  @HiveField(2)
  final int amountClp;
  @HiveField(3)
  final int costCoins;
  @HiveField(4)
  final String imageUrl;
  @HiveField(5)
  final String type;

  GiftCardOption({
    required this.id,
    required this.storeName,
    required this.amountClp,
    required this.costCoins,
    required this.imageUrl,
    required this.type,
  });
}

@HiveType(typeId: 1)
class RedeemedGiftCard extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final GiftCardOption option;
  @HiveField(2)
  final String code;
  @HiveField(3)
  final DateTime dateRedeemed;

  RedeemedGiftCard({
    required this.id,
    required this.option,
    required this.code,
    required this.dateRedeemed,
  });
}
