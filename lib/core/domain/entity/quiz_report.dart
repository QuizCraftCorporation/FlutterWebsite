class QuizReport {
  final int quizId;
  // final Map<int, Set<int>> correctOptionIds;
  final Map<int, Set<int>> chosenOptionIds;
  final Map<int, double> scores;
  final double totalScore;

  const QuizReport({
    required this.quizId,
    required this.chosenOptionIds,
    // required this.correctOptionIds,
    required this.scores,
    required this.totalScore,
  });

  factory QuizReport.fromJson(Map<String, dynamic> json) {
    Map<int, Set<int>> chosenOptionIds = {};
    Map<int, Set<int>> correctOptionIds = {};
    Map<int, double> scores = {};
    for (Map<String, dynamic> answer in json['answers']) {
      scores[answer['question_id']] = answer['score'];
      Set<int> correct = {}, chosen = {};
      // for (int i = 0; i < answer['correct_answer_ids'].length; i++){
      //   correct.add(answer['correct_answer_ids'][i]);
      // }
      for (int i = 0; i < answer['user_answer'].length; i++){
        chosen.add(answer['user_answer'][i]);
      }
      correctOptionIds[answer['question_id']] = correct;
      chosenOptionIds[answer['question_id']] = chosen;
    }
    return QuizReport(
      quizId: json['quiz_id'],
      totalScore: json['total_score'],
      chosenOptionIds: chosenOptionIds,
      // correctOptionIds: correctOptionIds,
      scores: scores,
    );
  }
}
