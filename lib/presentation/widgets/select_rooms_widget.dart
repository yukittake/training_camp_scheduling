import 'package:training_camp_scheduling/presentation/state/camp_state.dart';
import 'package:training_camp_scheduling/presentation/theme/colors.dart';
import 'package:training_camp_scheduling/presentation/theme/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class SelectRoomsWidget extends ConsumerStatefulWidget {
  final int _campIndex;
  final int _rooms;
  final double _width;
  const SelectRoomsWidget({super.key,required campIndex,required rooms,required width}):
    _campIndex=campIndex,
    _rooms=rooms,
    _width=width;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectRoomsWidgetState();
}

class _SelectRoomsWidgetState extends ConsumerState<SelectRoomsWidget> {
  late int _selectedNumber;
  @override
  void initState(){
    super.initState();
    _selectedNumber=widget._rooms-1;
  }
  void _showDialog(Widget child){
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
        ),
        height: 300,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SafeArea(top: false, child: child),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDialog(
        Column(
          children: [
            Row(
              children: [
                SizedBox(width: 10,),
                TextButton(onPressed: ()=>Navigator.pop(context), style: TextButton.styleFrom(overlayColor: AppColor.black),child: Text("キャンセル",style:AppText.normal),),
                Expanded(child: SizedBox(),),
                TextButton(onPressed: (){
                  final notifier=ref.read(campStateNotifierProvider.notifier);
                  final campState=ref.read(campStateNotifierProvider);
                  notifier.updateRooms(campState[widget._campIndex],_selectedNumber+1); //_selectedNumberは添字のため+1
                  Navigator.pop(context);
                }, style: TextButton.styleFrom(overlayColor: AppColor.black),child: Text("保存",style:AppText.normal),),
                SizedBox(width: 10,),
              ],
            ),
            Expanded(
              child: CupertinoPicker(
                magnification: 1.22,
                squeeze: 1.2,
                useMagnifier: true,
                itemExtent: 40.0,
                scrollController: FixedExtentScrollController(initialItem: widget._rooms-1), //_roomsは部屋の数、initialItemは添字のため-1
                onSelectedItemChanged: (int n) {
                  setState(() {
                    _selectedNumber = n;
                  });
                },
                children: List<Widget>.generate(9, (int index) {
                  return Center(child: Text("${index+1}"));
                }),
              ),
            ),
          ],
        )
      ),
      child: Container(
        width: widget._width,
        height: 30,
        decoration: BoxDecoration(
          color: AppColor.greyBack,
          border: Border.all(
            color:AppColor.greyMainString,
            width:1
          ),
          borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 5),
                child: Text("スタジオ数：",style: AppText.smaller,),
              ),
              Text("${widget._rooms}",style: AppText.smaller,),
              Expanded(child: SizedBox(),),
              Icon(Icons.expand_more)
            ],
          ),
        ),
      ),
    );
  }
}
