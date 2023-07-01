class QuizPreview {
  final int quizId;
  final String title;
  final String description;

  const QuizPreview(
      {required this.quizId, required this.title, required this.description});

  factory QuizPreview.fromJson(json) {
    return QuizPreview(
      quizId: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
