class TrainingCamp {
  String _campTitle;
  List<Band> _bands;

  String get campTitle => _campTitle;
  List<Band> get bands => _bands;

  TrainingCamp({String? campTitle, List<Band>? bands})
      : _campTitle = campTitle ?? "無題", // campTitleがnullなら"無題"
        _bands = bands ?? <Band>[];       // bandsがnullなら空のリスト
}

class Band{
  String _bandTitle;
  List<String> _members;
  Band({String? bandTitle,List<String>? members})
    : _bandTitle=bandTitle ?? "バンド名前",
      _members=members ?? <String>[];
}