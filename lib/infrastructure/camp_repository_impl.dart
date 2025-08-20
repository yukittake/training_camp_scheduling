import 'package:training_camp_scheduling/domain/entities/band.dart';
import 'package:training_camp_scheduling/domain/entities/camp.dart';
import 'package:training_camp_scheduling/domain/repositories/camp_repository.dart';
import 'package:training_camp_scheduling/infrastructure/hive_camp_data_source.dart';

class CampRepositoryImpl implements CampRepository{
  final HiveCampDataSource ds;
  CampRepositoryImpl(this.ds);

  @override
  List<Camp> fetchAll() => ds.fetchAll();

  @override
  void add(String campTitle, List<Band> bands, List<List<Band>> schedule, int rooms) => ds.add(campTitle,bands,schedule,rooms);

  @override
  void delete(String id) => ds.delete(id);

  @override
  void edit(Camp camp) => ds.edit(camp);
}