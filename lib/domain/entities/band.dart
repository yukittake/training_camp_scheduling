class Band{
  String _bandTitle;
  List<String> _members;
  bool _open;

  String get bandTitle => _bandTitle;
  List<String> get members => _members;
  bool get open => _open;
  set bandTitle(String s) => _bandTitle=s;
  set members(List<String> lm) => _members=lm;
  set open(bool b) => _open=b;

  Band({required bandTitle,required members,required open}):
    _bandTitle=bandTitle,
    _members=members,
    _open=open;

  Band copyWith({String? bandTitle,List<String>? members,bool? open}){
    return Band(
      bandTitle: bandTitle ?? _bandTitle,
      members: members != null ? List.from(members).cast<String>() : List.from(this.members).cast<String>(),
      open: open ?? _open
    );
  }

  bool hasEmptyMember(){
    for(int i=0;i<_members.length;i++){
      if(_members[i].trim().isEmpty) return true;
    }
    return false;
  }
  List<int> emptyMemberIndex(){
      return [
          for (int i = 0; i < _members.length; i++)
            if (_members[i].trim().isEmpty) i 
      ];    
  }
}