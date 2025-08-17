// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camp.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CampAdapter extends TypeAdapter<Camp> {
  @override
  final int typeId = 1;

  @override
  Camp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Camp()
      .._campTitle = fields[0] as String
      .._bands = (fields[1] as List).cast<Band>()
      .._id = fields[2] as String
      .._schedule = (fields[3] as List)
          .map((dynamic e) => (e as List).cast<Band>())
          .toList()
      .._rooms = fields[4] as int;
  }

  @override
  void write(BinaryWriter writer, Camp obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj._campTitle)
      ..writeByte(1)
      ..write(obj._bands)
      ..writeByte(2)
      ..write(obj._id)
      ..writeByte(3)
      ..write(obj._schedule)
      ..writeByte(4)
      ..write(obj._rooms);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CampAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
