import 'package:training_camp_scheduling/domain/entities/camp.dart';
import 'package:training_camp_scheduling/domain/repositories/camp_repository.dart';

class GetCamps {
  final CampRepository repo;
  GetCamps(this.repo);

  List<Camp> call() => repo.fetchAll();
}