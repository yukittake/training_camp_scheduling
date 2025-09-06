import 'package:training_camp_scheduling/domain/repositories/garbage_repository.dart';

class CompletelyDeleteCamp {
  final GarbageRepository repo;
  CompletelyDeleteCamp(this.repo);

  void call(String id) => repo.delete(id);
}