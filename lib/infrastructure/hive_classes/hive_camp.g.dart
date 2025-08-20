// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_camp.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveCampAdapter extends TypeAdapter<HiveCamp> {
  @override
  final int typeId = 1;

  @override
  HiveCamp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveCamp(
      campTitle: fields[0] as String,
      bands: (fields[1] as List).cast<HiveBand>(),
      id: fields[2] as String,
      schedule: (fields[3] as List)
          .map((dynamic e) => (e as List).cast<HiveBand>())
          .toList(),
      rooms: fields[4] as int,
      createdAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, HiveCamp obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj._campTitle)
      ..writeByte(1)
      ..write(obj._bands)
      ..writeByte(2)
      ..write(obj._id)
      ..writeByte(3)
      ..write(obj._schedule)
      ..writeByte(4)
      ..write(obj._rooms)
      ..writeByte(5)
      ..write(obj._createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveCampAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
