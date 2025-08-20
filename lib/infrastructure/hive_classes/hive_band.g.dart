// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_band.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveBandAdapter extends TypeAdapter<HiveBand> {
  @override
  final int typeId = 0;

  @override
  HiveBand read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveBand(
      bandTitle: fields[0] as String,
      members: (fields[1] as List).cast<String>(),
      open: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HiveBand obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj._bandTitle)
      ..writeByte(1)
      ..write(obj._members)
      ..writeByte(2)
      ..write(obj._open);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveBandAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
