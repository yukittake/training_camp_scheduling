import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_camp_scheduling/presentation/state/garbage_state.dart';
import 'package:training_camp_scheduling/presentation/theme/fonts.dart';

class DeleteActionSheet extends ConsumerWidget {
  final List<int> _selectedIndices;
  final String _text;
  const DeleteActionSheet({super.key,required selectedIndices, required text}): 
    _selectedIndices=selectedIndices,
    _text=text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoActionSheet(
      title: Text(_text,style: AppText.formAnnotation,),
      actions: [
        CupertinoActionSheetAction(onPressed: (){
          final garbageState=ref.read(garbageStateNotifierProvider);
          final notifier=ref.read(garbageStateNotifierProvider.notifier);
          for(int i in _selectedIndices){notifier.completelyDelete(garbageState[i].id);}
          Navigator.of(context).pop(true);
        }, child: Text("完全に削除",style: AppText.largeDelete,)),
      ],
      cancelButton: CupertinoActionSheetAction(onPressed: (){
        Navigator.of(context).pop(false);
      }, child: Text("キャンセル",style: AppText.normal,)),
    );
  }
}