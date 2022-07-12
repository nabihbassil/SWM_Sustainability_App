

class Facts {
  String? awatitle;
  String? awaimg;
  String? awatext;
  String? parentmoduleid;

  Facts({this.awatitle, this.awaimg, this.awatext, this.parentmoduleid});

  factory Facts.fromJson(Map<String, dynamic> json) {
    return Facts(
        awatitle: json['awatitle'],
        awatext: json['awatext'],
        awaimg: json['awaimg'],
        parentmoduleid: json['parentmoduleid']);
  }
}
