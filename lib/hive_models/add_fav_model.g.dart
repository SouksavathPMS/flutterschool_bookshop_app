// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_fav_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddFavModelAdapter extends TypeAdapter<AddFavModel> {
  @override
  final int typeId = 0;

  @override
  AddFavModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddFavModel(
      bookId: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AddFavModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.bookId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddFavModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
