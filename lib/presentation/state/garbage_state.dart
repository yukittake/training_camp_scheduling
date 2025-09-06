import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:training_camp_scheduling/application/usecases/back_from_garbage.dart';
import 'package:training_camp_scheduling/application/usecases/completely_delete_camp.dart';
import 'package:training_camp_scheduling/application/usecases/get_garbage.dart';
import 'package:training_camp_scheduling/domain/entities/camp.dart';
import 'package:training_camp_scheduling/presentation/state/camp_state.dart';
import 'package:training_camp_scheduling/presentation/state/providers.dart';

part 'garbage_state.g.dart';

@riverpod
class GarbageStateNotifier extends _$GarbageStateNotifier {
  late final GetGarbage _getGarbage=ref.read(getGarbageProvider);
  late final CompletelyDeleteCamp _completelyDeleteCamp=ref.read(completelyDeleteCampProvider);
  late final BackFromGarbage _backFromGarbage=ref.read(backFromGarbageProvider);

  @override
  List<Camp> build() => _getGarbage();

  void refresh(){
    state=_getGarbage();
  }

  void completelyDelete(String id){
    _completelyDeleteCamp(id);
    state=_getGarbage();
  }

  void backFromGarbage(Camp camp){
    _backFromGarbage(camp);
    ref.read(campStateNotifierProvider.notifier).refresh();
    state=_getGarbage();
  }
}