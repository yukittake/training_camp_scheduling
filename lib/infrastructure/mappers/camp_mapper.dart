
import 'package:training_camp_scheduling/domain/entities/camp.dart';
import 'package:training_camp_scheduling/infrastructure/hive_classes/hive_camp.dart';
import 'package:training_camp_scheduling/infrastructure/mappers/band_mapper.dart';

extension CampToHive on Camp {
  HiveCamp toHive() => HiveCamp(
    campTitle: campTitle, 
    bands: bands.map((band) => band.toHive()).toList(), 
    id: id, 
    createdAt: createdAt,
    schedule: schedule.map((listBand) => listBand.map((band) => band.toHive(),).toList()).toList(), 
    rooms: rooms
  );
}

extension HiveToBand on HiveCamp {
  Camp toDomain() => Camp(
    campTitle: campTitle, 
    bands: bands.map((number) => number.toDomain()).toList(),
    id: id, 
    createdAt: createdAt,
    schedule: schedule.map((listBand) => listBand.map((band) => band.toDomain(),).toList()).toList(),
    rooms: rooms
  );
}