class SolvedQuiz {
  final int quizId;
  final Map<int, Set<int>> optionIds;

  const SolvedQuiz({required this.quizId, required this.optionIds});

  Map<String, dynamic> toJson(){
    List<Map<String, dynamic>> answers = [];
    for (int k in optionIds.keys){
      if (optionIds.containsKey(k)) {
        answers.add({
          'question_id': k,
          'user_answer': optionIds[k]!.toList(),
        });
      }
    }
    return {
      'quiz_id': quizId,
      'answers': answers,
    };
  }
}