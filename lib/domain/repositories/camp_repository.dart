import 'package:training_camp_scheduling/domain/entities/band.dart';
import 'package:training_camp_scheduling/domain/entities/camp.dart';

abstract class CampRepository {

  List<Camp> fetchAll();
  void delete(String id);
  void add(String campTitle,List<Band> bands,List<List<Band>> schedule,int rooms);
  void edit(Camp camp);

}