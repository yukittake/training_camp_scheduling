import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:training_camp_scheduling/application/types/camp.dart';
import 'package:training_camp_scheduling/domain/types/band.dart';
part 'camp_state.g.dart';

@riverpod
class CampStateNotifier extends _$CampStateNotifier {
  @override
   List<Camp> build() {
    return <Camp>[Camp(campTitle: "A"),Camp(campTitle: "B"),Camp(campTitle: "C")];
  }

  void add(){
    state = [...state, Camp()];
  }
  void delete(int index) {
    state = [...state]..removeAt(index);
  }
  void updateTitle(int index,String newTitle){
    final updated = [...state];
    updated[index].campTitle=newTitle;
    state=updated;
  }
  void addBand(int index) {
    final updated = [...state];
    updated[index].bands = [...updated[index].bands, Band()];
    state = updated;
  }
  void addMember(int index,int bandIndex){
    final updated = [...state];
    updated[index].bands[bandIndex].mambers=[...updated[index].bands[bandIndex].members,""];
    state=updated;
  }
}