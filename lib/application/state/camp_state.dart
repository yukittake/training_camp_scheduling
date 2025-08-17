import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:training_camp_scheduling/application/state/camp_box_provider.dart';
import 'package:training_camp_scheduling/domain/types/camp.dart';
import 'package:training_camp_scheduling/domain/types/band.dart';
part 'camp_state.g.dart';

@riverpod
class CampStateNotifier extends _$CampStateNotifier {
  @override
   List<Camp> build() {
    final campBox=ref.read(campBoxProvider);
    return campBox.values.toList();
  }

  void addCamp(){
    final campBox=ref.read(campBoxProvider);
    final newState=[...state, Camp()];
    campBox.add(Camp());
    state = newState;
  }
  void deleteCamp(int index) {
    final campBox=ref.read(campBoxProvider);
    final key=campBox.keyAt(index);
    campBox.delete(key);
    state = [...state]..removeAt(index);
  }

  void updateTitle(int index,String newTitle){
    final campBox=ref.read(campBoxProvider);
    final updated = [...state];
    final key=campBox.keyAt(index);
    updated[index].campTitle=newTitle;
    campBox.put(key,updated[index]);
    state=updated;
  }
  
  void addBand(int index) {
    final campBox=ref.read(campBoxProvider);
    final key=campBox.keyAt(index);
    final updated = [...state];
    updated[index].bands = [...updated[index].bands, Band()];
    campBox.put(key,updated[index]);
    state = updated;
  }
  void deleteBand(int index,int removeIndex){
    final campBox=ref.read(campBoxProvider);
    final key=campBox.keyAt(index);
    final updated = [...state];
    updated[index].bands.removeAt(removeIndex);
    campBox.put(key,updated[index]);
    state = updated;
  }
  void updateBand(int index,int bandIndex,String newBandTitle){
    final campBox=ref.read(campBoxProvider);
    final updated = [...state];
    final key=campBox.keyAt(index);
    updated[index].bands[bandIndex].bandTitle=newBandTitle;
    campBox.put(key,updated[index]);
    state=updated;
  }

  void addMember(int index,int bandIndex){
    final campBox=ref.read(campBoxProvider);
    final key=campBox.keyAt(index);
    final updated = [...state];
    updated[index].bands[bandIndex].members=[...updated[index].bands[bandIndex].members,""];
    campBox.put(key,updated[index]);
    state=updated;
  }
  void deleteMember(int index,int bandIndex,int removeIndex){
    final campBox=ref.read(campBoxProvider);
    final key=campBox.keyAt(index);
    final updated = [...state];
    updated[index].bands[bandIndex].members.removeAt(removeIndex);
    campBox.put(key,updated[index]);
    state = updated;
  }
  void updateMember(int index,int bandIndex,int memberIndex,String newMemberName){
    final campBox=ref.read(campBoxProvider);
    final updated = [...state];
    final key=campBox.keyAt(index);
    updated[index].bands[bandIndex].members[memberIndex]=newMemberName;
    campBox.put(key,updated[index]);
    state=updated;
  }

  void turnOpen(int index,int bandIndex){
    final campBox=ref.read(campBoxProvider);
    final updated = [...state];
    final key=campBox.keyAt(index);
    updated[index].bands[bandIndex].open=!updated[index].bands[bandIndex].open;
    campBox.put(key,updated[index]);
    state=updated;
  }

  void updateRooms(int index,int newRooms){
    final campBox=ref.read(campBoxProvider);
    final updated = [...state];
    final key=campBox.keyAt(index);
    updated[index].rooms=newRooms;
    campBox.put(key,updated[index]);
    state=updated;
  }
}