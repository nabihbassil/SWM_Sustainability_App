class Quiz {
/* 

The Quiz data model is used to fill the data of each quiz question. 
screens/home_screen.dart (home screen), screens/levels.dart (levels page), 
screens/profile_screen.dart (profile page).
Data is retrieved from both Quiz parent collection where we get points and
QNA collection which is a nested collection containing the rest of the data.

*/
  String? question; // Quiz question
  List? answers; // List of possible answers
  int? points; // Points earned by completing quiz
  String?
      explanation; // Info displayed about question after being answered by user
  String? correct; // Correct answer
  String? parentID; // ID of the parent in the Quiz Table.

  Quiz(
      {this.question,
      this.answers,
      this.points,
      this.explanation,
      this.correct,
      this.parentID});

//This function retrieves data from the Firebase database.
  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
        question: json['question'],
        answers: json['answers'],
        points: json['points'],
        explanation: json['explanation'],
        correct: json['correct'],
        parentID: json['parentID']);
  }
}
