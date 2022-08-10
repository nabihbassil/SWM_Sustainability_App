import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swm_app/model/facts_model.dart';

class FactService {
/* 

The Facts Service page contains functions that link the facts page to the 
Firebase database.

*/

/* 
  This function gets the facts related data from firebase and then adds them
  to a list. Each index of this list contains a Facts data model containing
  the required data.

  Inputs:
  * ID: this is the ID of the parent module (challenge) under which these facts
      fall under

  Outputs:
  * List containing Facts objects. each index is displayed on a page controlled
    by next and previous buttons to iterate between indexes.
  
*/
  Future<List<Facts>> getUserTaskList(ID) async {
    QuerySnapshot qShot = await FirebaseFirestore.instance
        .collection('awafacts')
        .where("parentmoduleid", isEqualTo: ID)
        .get(); // Firebase call to the  facts table

    //print("qshot is ${qShot.docs.length}  id is $id");

    return qShot.docs
        .map((doc) => Facts(
            awatext: doc.get("awatext"),
            awatitle: doc.get("awatitle"),
            awaimg: doc.get("awaimg")))
        .toList();
  }
}
