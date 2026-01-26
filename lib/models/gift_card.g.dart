// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GiftCardOptionAdapter extends TypeAdapter<GiftCardOption> {
  @override
  final int typeId = 0;

  @override
  GiftCardOption read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GiftCardOption(
      id: fields[0] as String,
      storeName: fields[1] as String,
      amountClp: fields[2] as int,
      costCoins: fields[3] as int,
      imageUrl: fields[4] as String,
      type: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GiftCardOption obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.storeName)
      ..writeByte(2)
      ..write(obj.amountClp)
      ..writeByte(3)
      ..write(obj.costCoins)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GiftCardOptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RedeemedGiftCardAdapter extends TypeAdapter<RedeemedGiftCard> {
  @override
  final int typeId = 1;

  @override
  RedeemedGiftCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RedeemedGiftCard(
      id: fields[0] as String,
      option: fields[1] as GiftCardOption,
      code: fields[2] as String,
      dateRedeemed: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, RedeemedGiftCard obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.option)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.dateRedeemed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RedeemedGiftCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
