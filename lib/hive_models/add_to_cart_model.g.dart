// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_to_cart_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddToCartModelAdapter extends TypeAdapter<AddToCartModel> {
  @override
  final int typeId = 1;

  @override
  AddToCartModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddToCartModel(
      bookId: fields[0] as String,
      amount: fields[1] as int,
      price: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AddToCartModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.bookId)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddToCartModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
