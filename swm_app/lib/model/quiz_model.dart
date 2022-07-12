

class Quiz {
  String? question;
  List? answers;
  int? points;
  String? explanation;
  String? correct;
  String? parentID;

  Quiz(
      {this.question,
      this.answers,
      this.points,
      this.explanation,
      this.correct,
      this.parentID});

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
