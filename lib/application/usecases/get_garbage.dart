import 'package:training_camp_scheduling/domain/entities/camp.dart';
import 'package:training_camp_scheduling/domain/repositories/garbage_repository.dart';

class GetGarbage {
  final GarbageRepository repo;
  GetGarbage(this.repo);

  List<Camp> call() => repo.fetchAll();
}