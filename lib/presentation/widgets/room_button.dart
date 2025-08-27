import 'package:flutter/material.dart';
import 'package:training_camp_scheduling/presentation/theme/colors.dart';
import 'package:training_camp_scheduling/presentation/theme/fonts.dart';

class RoomButton extends StatelessWidget {
  final void Function(int value) _onPressed;
  final int _currentRoom;
  final int _roomNumber;
  const RoomButton({super.key, required onPressed, required currentRoom, required roomNumber}):
    _onPressed=onPressed,
    _currentRoom=currentRoom,
    _roomNumber=roomNumber;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Center(
        child: GestureDetector(
          onTap: (){_onPressed(_roomNumber);}, 
          child: Container(
            color: AppColor.transparent,
            height: 40,
            width: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_roomNumber==0 ? "1st" : (_roomNumber==1 ? "2nd" : (_roomNumber==2 ? "3rd" : "${_roomNumber+1}th")),
                  style: _currentRoom==_roomNumber ? AppText.subTitle : AppText.greyMainString,
                ),
                _currentRoom==_roomNumber ? Icon(Icons.circle,size: 8,) : SizedBox(height: 0,width: 0,)
              ],
            )
          ),
        ),
      ),
    );
  }
}