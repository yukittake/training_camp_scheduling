import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_camp_scheduling/camp_state.dart';


class SecondPage extends ConsumerStatefulWidget {
  final int index;
  const SecondPage({super.key,required this.index});

  @override
  ConsumerState<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends ConsumerState<SecondPage> {
  late final TextEditingController myController;
  @override
  void initState(){
    super.initState();
    final campState=ref.read(campStateNotifierProvider);
    myController=TextEditingController(text:campState[widget.index].campTitle);
  }
  @override
  void dispose(){
    myController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: //Text(campState[index].campTitle),
        //TextFormField(style:TextStyle(fontSize: 30),initialValue:"新規",decoration:  const InputDecoration(border: InputBorder.none),)
      ),
      body: ListView(children: [
          SizedBox(width: double.infinity,height:300,child: Placeholder(),),
          TextField(controller: myController,)
        ]
      ),
    );
  }
}