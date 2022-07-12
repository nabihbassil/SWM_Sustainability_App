import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swm_app/model/quiz_model.dart';

class QuizService {
  int counter = 0;

  Future<List<Quiz>> getQuizList(id) async {
    int points = 0;
    String docID = "";
    var qShot = await FirebaseFirestore.instance
        .collection('quiz')
        .where("parentmoduleid", isEqualTo: id)
        .get();

// Get data from docs and convert map to List
    List allData = qShot.docs.map((doc) => doc.data()).toList();
    List<String> allData1 = qShot.docs.map((doc) => docID = doc.id).toList();
    points = allData.elementAt(0)["ptsReward"];

    print("docID $docID");
    print("docID1 ${allData1.elementAt(0)}");

    return await FirebaseFirestore.instance
        .collection("quiz")
        .doc(docID)
        .collection("QNA")
        .get()
        .then((value) => value.docs
            .map((e) => Quiz(
                question: e.get("question"),
                answers: e.get("answers"),
                explanation: e.get("explanation"),
                points: points,
                parentID: docID,
                correct: e.get("correct")))
            .toList());
  }
}
