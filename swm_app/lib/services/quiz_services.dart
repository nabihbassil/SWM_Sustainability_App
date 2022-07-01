import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swm_app/model/Quiz_model.dart';

class QuizService {
  int counter = 0;

  Future<List<Quiz>> getQuizList(id) async {
    int points = 0;
    int parentID = 0;
    String docID = "";
    QuerySnapshot qShot = await FirebaseFirestore.instance
        .collection('quiz')
        .where("parentmoduleid", isEqualTo: id)
        .get();

    qShot.docs.map((doc) async => {points = doc.get("ptsReward")});

    qShot.docs.map((doc) async => {parentID = doc.get("parentmoduleID")});

    qShot.docs.map((doc) async => {docID = doc.id});

    QuerySnapshot qShot1 = await FirebaseFirestore.instance
        .collection("quiz")
        .doc(docID)
        .collection("QNA")
        .get();

    return qShot1.docs
        .map((doc) => Quiz(
            question: doc.get("question"),
            answers: doc.get("answers"),
            explanation: doc.get("explanation"),
            points: points,
            parentID: parentID,
            correct: doc.get(["correct"])))
        .toList();
  }
}
