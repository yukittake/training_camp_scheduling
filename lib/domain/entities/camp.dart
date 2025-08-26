import 'dart:convert';
import 'package:training_camp_scheduling/domain/entities/band.dart';

class Camp {
  String _id;
  DateTime _createdAt;
  String _campTitle;
  List<Band> _bands;
  List<List<Band>> _schedule;
  int _rooms;


  String get campTitle => _campTitle;
  List<Band> get bands => _bands;
  String get id => _id;
  List<List<Band>> get schedule => _schedule;
  int get rooms => _rooms;
  DateTime get createdAt => _createdAt;
  set campTitle(String s) => _campTitle=s;
  set bands(List<Band> lb) => _bands=lb;
  set id(String s) => _id=s;
  set schedule(List<List<Band>> s) => _schedule=s;
  set rooms(int r) => _rooms=r;
  set createdAt(DateTime t) => _createdAt=t;

  Camp({required campTitle,required bands,required id,required schedule,required rooms,required createdAt})
      : _campTitle = campTitle,
        _bands = bands,
        _id = id,
        _createdAt = createdAt,
        _schedule = schedule,
        _rooms = rooms;

  Camp copyWith({String? campTitle,List<Band>? bands,String? id,List<List<Band>>? schedule,int? rooms,DateTime? createdAt}){
    return Camp(
      campTitle: campTitle ?? _campTitle,
      bands: (bands ?? _bands).map((b) => b.copyWith()).toList(),
      id: id ?? _id,
      schedule: (schedule ?? _schedule).map((listBand) => listBand.map((b) => b.copyWith()).toList()).toList(),
      rooms: rooms ?? _rooms,
      createdAt: createdAt ?? _createdAt
    );
  }

  bool hasEmptyBandTitle(){
    for(int i=0;i<_bands.length;i++){
      if(_bands[i].bandTitle.trim().isEmpty) return true;
    }
    return false;
  }
  List<int> emptyBandTitleIndex(){
    return [for(int i=0;i<_bands.length;i++)
      if(_bands[i].bandTitle.trim().isEmpty) i
    ];
  }

  bool hasEmptyMember(){
    for(int i=0;i<_bands.length;i++){
      if(_bands[i].hasEmptyMember()==true) return true;
    }
    return false;
  }
  List<List<int>> emptyMemberIndex(){
    return [
      for (int i = 0; i < _bands.length; i++)
        _bands[i].emptyMemberIndex()
    ];
  }

  List<List<Band>> greedyScheduling(){
    Set<int> usedIndex = {};
    List<List<Band>> result=[];

    while(usedIndex.length < _bands.length){
      List<Band> currentGroup=[];
      Set<String> usedPeople={};

      for(int i=0;i<_bands.length;i++){
        if(usedIndex.contains(i)) continue;
        if(_bands[i].members.toSet().intersection(usedPeople).isEmpty){
          currentGroup.add(_bands[i]);
          usedIndex.add(i);
          usedPeople.addAll(_bands[i].members);
        }

        if(currentGroup.length == _rooms) break;
      }

      result.add(currentGroup);
    }
    return result;
  }

  List<int> encodingSchedule() {
    String escape(String s) {
      if (s.contains(RegExp(r'[",\r\n]'))) {
        return '"${s.replaceAll('"', '""')}"';
      }
      return s;
    }

    final csv = _schedule
      .map((row) => row.map((v) => escape((v).bandTitle)).join(','))
      .join('\r\n');
    return utf8.encode('\u{FEFF}$csv');
  }
}