import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:training_camp_scheduling/training_camp_class.dart';
part 'camp_state.g.dart';

@riverpod
class CampStateNotifier extends _$CampStateNotifier {
  @override
   List<TrainingCamp> build() {
    return <TrainingCamp>[TrainingCamp(campTitle: "A"),TrainingCamp(campTitle: "B"),TrainingCamp(campTitle: "C")];
  }

  void add(){
    state = [...state, TrainingCamp()];
  }

  void delete(int index) {
  state = [...state]..removeAt(index);
  }
}