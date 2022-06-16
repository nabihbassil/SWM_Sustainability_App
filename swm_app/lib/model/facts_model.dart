import 'dart:ui';

import 'package:flutter/material.dart';

class Facts {
  String? awatitle;
  String? awaimg;
  String? awatext;
  String? parentmoduleid;

  Facts({this.awatitle, this.awaimg, this.awatext, this.parentmoduleid});

  factory Facts.fromJson(Map<String, dynamic> json) {
    return Facts(
        awatext: json['awatext'],
        awatitle: json['awatitle'],
        awaimg: json['awaimg'],
        parentmoduleid: json['parentmoduleid']);
  }
}
