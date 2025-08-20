import 'package:training_camp_scheduling/domain/repositories/camp_repository.dart';

class AddNamelessCamp {
  final CampRepository repo;
  AddNamelessCamp(this.repo);

  void call() => repo.add("新規",[],[],1);
}