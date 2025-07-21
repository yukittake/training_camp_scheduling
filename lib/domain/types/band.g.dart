// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'band.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BandAdapter extends TypeAdapter<Band> {
  @override
  final int typeId = 0;

  @override
  Band read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Band()
      .._bandTitle = fields[0] as String
      .._members = (fields[1] as List).cast<String>();
  }

  @override
  void write(BinaryWriter writer, Band obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._bandTitle)
      ..writeByte(1)
      ..write(obj._members);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BandAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
