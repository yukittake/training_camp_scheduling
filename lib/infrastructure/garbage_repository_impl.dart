import 'package:training_camp_scheduling/domain/entities/camp.dart';
import 'package:training_camp_scheduling/domain/repositories/garbage_repository.dart';
import 'package:training_camp_scheduling/infrastructure/hive_garbage_data_source.dart';

class GarbageRepositoryImpl implements GarbageRepository{
  final HiveGarbageDataSource ds;
  GarbageRepositoryImpl(this.ds);

  @override
  List<Camp> fetchAll() => ds.fetchAll();

  @override
  void delete(String id) => ds.delete(id);

  @override
  void edit(Camp camp) => ds.edit(camp);
}