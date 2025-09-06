import 'package:training_camp_scheduling/domain/entities/camp.dart';

abstract class GarbageRepository{

  List<Camp> fetchAll();
  void delete(String id);
  void edit(Camp camp);

}