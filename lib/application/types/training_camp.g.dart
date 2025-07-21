// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_camp.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrainingCampAdapter extends TypeAdapter<TrainingCamp> {
  @override
  final int typeId = 1;

  @override
  TrainingCamp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrainingCamp()
      .._campTitle = fields[0] as String
      .._bands = (fields[1] as List).cast<Band>();
  }

  @override
  void write(BinaryWriter writer, TrainingCamp obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._campTitle)
      ..writeByte(1)
      ..write(obj._bands);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrainingCampAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
