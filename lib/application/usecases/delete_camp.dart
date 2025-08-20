import 'package:training_camp_scheduling/domain/repositories/camp_repository.dart';

class DeleteCamp {
  final CampRepository repo;
  DeleteCamp(this.repo);

  void call(String id) => repo.delete(id);
}