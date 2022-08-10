import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swm_app/model/quiz_model.dart';

class QuizService {
/* 

The Quiz Service page contains functions that link the quiz page to the 
Firebase database.

*/

/* 
  This function gets quiz related data (ID, points) from the firebase collection
  "quiz". 
  Then we use the referenec ID of the resulting data to call the sub-collection
  "QNA" where we get data such as question, possible answers, correct answer
   etc....

  Inputs:
  * ID: this is the ID of the parent module (challenge) under which the quiz
      falls under

  Outputs:
  * List containing Facts objects. each index is displayed on a page controlled
    by next and previous buttons to iterate between indexes.
  
*/
  Future<List<Quiz>> getQuizList(ID) async {
    int points = 0;
    String docID = "";

    var qShot = await FirebaseFirestore.instance
        .collection('quiz')
        .where("parentmoduleid", isEqualTo: ID)
        .get(); // Firebase call to the main quiz table

    // Get data from docs and convert map to List
    List allData = qShot.docs.map((doc) => doc.data()).toList();

    // Get reference ID from docs
    List<String> allData1 = qShot.docs.map((doc) => docID = doc.id).toList();

    //Get points won if quiz is passed
    points = allData.elementAt(0)["ptsReward"];

// Firebase call to the sub-collection QNA
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
