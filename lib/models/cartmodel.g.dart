// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartmodeAdapter extends TypeAdapter<Cartmode> {
  @override
  final int typeId = 0;

  @override
  Cartmode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cartmode()
      ..title = fields[0] as String
      ..price = fields[1] as dynamic
      ..image = fields[2] as String
      ..rating = fields[3] as dynamic;
  }

  @override
  void write(BinaryWriter writer, Cartmode obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartmodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
