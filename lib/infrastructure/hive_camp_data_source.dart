import 'package:training_camp_scheduling/domain/entities/band.dart';
import 'package:training_camp_scheduling/domain/entities/camp.dart';
import 'package:training_camp_scheduling/infrastructure/hive_classes/hive_camp.dart';
import 'package:training_camp_scheduling/infrastructure/mappers/camp_mapper.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

final Uuid uuid = Uuid();

class HiveCampDataSource {
  final Box<HiveCamp> hiveCampBox = Hive.box<HiveCamp>('HiveCampBox');

  List<Camp> fetchAll() {
    return hiveCampBox.values.map((e) => e.toDomain()).toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }
  void delete(String id){
    hiveCampBox.delete(id);
  }
  void add(String campTitle,List<Band> bands,List<List<Band>> schedule,int rooms){
    final id=uuid.v4();
    final createdAt=DateTime.now();
    final camp=Camp(id: id,campTitle: campTitle,bands: bands,schedule: schedule,rooms: rooms,createdAt: createdAt);
    hiveCampBox.put(id,camp.toHive());
  }
  void edit(Camp camp){
    hiveCampBox.put(camp.id,camp.toHive());
  }
}