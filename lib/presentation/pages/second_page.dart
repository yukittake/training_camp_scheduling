import 'package:training_camp_scheduling/domain/entities/band.dart';
import 'package:training_camp_scheduling/presentation/state/camp_state.dart';
import 'package:training_camp_scheduling/presentation/theme/colors.dart';
import 'package:training_camp_scheduling/presentation/theme/fonts.dart';
import 'package:training_camp_scheduling/presentation/widgets/delete_overlay_widget.dart';
import 'package:training_camp_scheduling/presentation/widgets/first_schedule_widget.dart';
import 'package:training_camp_scheduling/presentation/widgets/manage_band_widget.dart';
import 'package:training_camp_scheduling/presentation/widgets/second_page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_camp_scheduling/presentation/widgets/second_schedule_widget.dart';

class SecondPage extends ConsumerStatefulWidget {
  final int campIndex;
  const SecondPage({super.key,required this.campIndex});

  @override
  ConsumerState<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends ConsumerState<SecondPage> {
  late final TextEditingController _titleController;
  final List<List<TextEditingController>> _bandControllerList=[]; //listの先頭がバンド名、それ以降がメンバー
  final List<FocusNode> _focusNodeList=[];
  final List<LayerLink> _links=[];
  late final ScrollController _scrollController;
  OverlayEntry? _overlayEntry;

  int _currentPageIndex=0;

  void _removeDeleteOverlay(){
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
  }
  void _createDeleteOverlay(int bandIndex,int members){
    _removeDeleteOverlay();
    _overlayEntry = OverlayEntry(builder: (context) {
      return DeleteOverlayWidget(removeDeleteOverlay: _removeDeleteOverlay, links: _links, bandIndex: bandIndex, members: members, campIndex: widget.campIndex, bandControllerList: _bandControllerList, focusNodeList: _focusNodeList);
    },);
    Overlay.of(context,debugRequiredFor: widget).insert(_overlayEntry!);
  }

  @override
  void initState(){
    super.initState();
    final campState=ref.read(campStateNotifierProvider);
    _scrollController=ScrollController();
    _titleController=TextEditingController(text:campState[widget.campIndex].campTitle);
    for(Band temp in campState[widget.campIndex].bands){
      List<TextEditingController> templ=[TextEditingController(text:temp.bandTitle)];
      _focusNodeList.add(FocusNode());
      _links.add(LayerLink());
      for(String str in temp.members){
        templ.add(TextEditingController(text:str));
      }
      _bandControllerList.add(templ);
    }
  }
  @override
  void dispose(){
    _scrollController.dispose();
    _titleController.dispose();
    for(FocusNode temp in _focusNodeList){
      temp.dispose();
    }
    for(List<TextEditingController> tempList in _bandControllerList){
      for(TextEditingController temp in tempList){
        temp.dispose();
      }
    }
    _removeDeleteOverlay();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final campState=ref.watch(campStateNotifierProvider);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: SecondPageAppBar(titleController: _titleController, currentPageIndex: _currentPageIndex, campIndex: widget.campIndex, bandControllerList: _bandControllerList, focusNodeList: _focusNodeList, links: _links, scrollController: _scrollController),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentPageIndex,
          onDestinationSelected: (value) {
            setState(() {
              _currentPageIndex = value;
            });
          },
          backgroundColor: AppColor.white,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          indicatorColor: AppColor.white,
          destinations: [
            NavigationDestination(
              selectedIcon: Icon(Icons.diversity_3),
              icon: Icon(Icons.diversity_3,color: AppColor.greyWidgetLine,),
              label: 'バンド管理',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.calendar_today),
              icon: Icon(Icons.calendar_today,color: AppColor.greyWidgetLine,),
              label: 'スケジューリング',
            ),
          ],
        ),
        body:[
        //バンド管理
          if(campState[widget.campIndex].bands.isEmpty) Center(child: Text("＋でバンドを追加",style:AppText.annotation,))
          else ListView.separated(
            controller: _scrollController,
            itemCount: campState[widget.campIndex].bands.length,
            itemBuilder: (BuildContext context, int index){
              final aBand=campState[widget.campIndex].bands[index];
              return ManageBandWidget(aBand: aBand, bandIndex: index, campIndex: widget.campIndex, links: _links, bandControllerList: _bandControllerList, overlayEntry: _overlayEntry, createDeleteOverlay: _createDeleteOverlay, removeDeleteOverlay: _removeDeleteOverlay, focusNodeList: _focusNodeList, scrollController: _scrollController);
            },
            separatorBuilder: (BuildContext context, int index) => const Padding(padding: EdgeInsets.only(top: 30),),
          )
        ,
        //スケジューリング
          if(campState[widget.campIndex].schedule.isEmpty) FirstScheduleWidget(campIndex: widget.campIndex,rooms: campState[widget.campIndex].rooms,bandControllerList: _bandControllerList,)
          else SecondScheduleWidget(campIndex: widget.campIndex,rooms: campState[widget.campIndex].rooms,bandControllerList: _bandControllerList)
        ][_currentPageIndex]
      ),
    );
  }
}