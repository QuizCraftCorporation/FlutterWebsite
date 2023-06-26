class QuizReport {
  final int quizId;
  final Map<int, Set<int>> correctOptionIds;
  final Map<int, Set<int>> chosenOptionIds;
  final Map<int, double> scores;
  final double totalScore;

  const QuizReport({
    required this.quizId,
    required this.chosenOptionIds,
    required this.correctOptionIds,
    required this.scores,
    required this.totalScore,
  });

  factory QuizReport.fromJson(Map<String, dynamic> json) {
    Map<int, Set<int>> chosenOptionIds = {};
    Map<int, Set<int>> correctOptionIds = {};
    Map<int, double> scores = {};
    for (Map<String, dynamic> answer in json['scored_answers']) {
      scores[answer['question_id']] = answer['score'];
      correctOptionIds[answer['question_id']] = {answer['correct_answer_id']};
      chosenOptionIds[answer['question_id']] = {answer['chosen_option_id']};
    }
    return QuizReport(
      quizId: json['quiz_id'],
      totalScore: json['total_score'],
      chosenOptionIds: chosenOptionIds,
      correctOptionIds: correctOptionIds,
      scores: scores,
    );
  }
}
