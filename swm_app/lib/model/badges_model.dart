import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/material.dart';

class Badges {
  String? module;
  String? icon;
  Bool? earned;

  Badges({this.module, this.icon, this.earned});

  factory Badges.fromJson(Map<String, dynamic> json) {
    return Badges(
        module: json['module'], icon: json['icon'], earned: json['earned']);
  }
}
