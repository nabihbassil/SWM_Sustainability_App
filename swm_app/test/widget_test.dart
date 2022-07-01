// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swm_app/services/user_service.dart';

import 'package:swm_app/main.dart';

void main() {
  updateModuleLogic(1);

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

void updateModuleLogic(ID) async {
  List L1 = ['0'];
  ID = 1;
  print("in func $ID");

  await UserService().GetAllActionDone(ID).then((value) => L1 = value);

  print("L1 $L1");

  var DoneTasksLength = await FirebaseFirestore.instance
      .collection('takeactions')
      .where("parentmoduleid", isEqualTo: ID)
      .where(FieldPath.documentId, whereIn: L1)
      .snapshots()
      .length;

  print("DOOOOOOOOONNNEEEEEE $DoneTasksLength");

  var notDoneTasksLength = await FirebaseFirestore.instance
      .collection('takeactions')
      .where("parentmoduleid", isEqualTo: ID)
      .where(FieldPath.documentId, whereNotIn: L1)
      .snapshots()
      .length;

  print("NOOOOTTT $notDoneTasksLength");
}
