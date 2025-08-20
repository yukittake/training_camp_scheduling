import 'package:training_camp_scheduling/presentation/state/camp_state.dart';
import 'package:training_camp_scheduling/presentation/theme/colors.dart';
import 'package:training_camp_scheduling/presentation/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecondPageAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const SecondPageAppBar({
    super.key,
    required TextEditingController titleController,
    required int currentPageIndex,
    required int campIndex,
    required List<List<TextEditingController>> bandControllerList,
    required List<FocusNode> focusNodeList,
    required List<LayerLink> links,
    required ScrollController scrollController,
  }) : _titleController = titleController, _bandControllerList = bandControllerList, _focusNodeList = focusNodeList, _links = links, _scrollController = scrollController, _currentPageIndex=currentPageIndex,_campIndex=campIndex;

  final TextEditingController _titleController;
  final int _currentPageIndex;
  final int _campIndex;
  final List<List<TextEditingController>> _bandControllerList;
  final List<FocusNode> _focusNodeList;
  final List<LayerLink> _links;
  final ScrollController _scrollController;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return AppBar(
      centerTitle: false,
      backgroundColor: AppColor.white,
      surfaceTintColor: Colors.transparent,
      title:TextField(
        decoration: const InputDecoration(
          border: InputBorder.none
        ),
        controller: _titleController,
        style:AppText.title,
        onChanged: (text){
          final notifier=ref.read(campStateNotifierProvider.notifier);
          final campState=ref.read(campStateNotifierProvider);
          notifier.updateCampTitle(campState[_campIndex],text);
        },
      ),
      actions: (_currentPageIndex==0) ? [IconButton(onPressed: (){
        final notifier=ref.read(campStateNotifierProvider.notifier);
        final campState=ref.read(campStateNotifierProvider);
        notifier.addNamelessBand(campState[_campIndex]);
      
        _bandControllerList.add([TextEditingController(text:"")]);
        _focusNodeList.add(FocusNode());
        _links.add(LayerLink());
    
        WidgetsBinding.instance.addPostFrameCallback((_){
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOutCubic
          );
        });
      }, icon: Icon(Icons.add_circle,size: 45,color: AppColor.black,))] : []
    );
  }
}