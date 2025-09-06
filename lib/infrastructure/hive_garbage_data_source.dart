import 'package:training_camp_scheduling/domain/entities/camp.dart';
import 'package:training_camp_scheduling/infrastructure/hive_classes/hive_camp.dart';
import 'package:training_camp_scheduling/infrastructure/mappers/camp_mapper.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

final Uuid uuid = Uuid();

class HiveGarbageDataSource {
  final Box<HiveCamp> hiveGarbageBox = Hive.box<HiveCamp>('HiveGarbageBox');

  List<Camp> fetchAll() {
    return hiveGarbageBox.values.map((e) => e.toDomain()).toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }
  void delete(String id){
    hiveGarbageBox.delete(id);
  }
  void edit(Camp camp){
    hiveGarbageBox.put(camp.id,camp.toHive());
  }
}