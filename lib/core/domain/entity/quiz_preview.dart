class QuizPreview {
  final int quizId;
  final String title;
  final String description;
  final bool ready;

  const QuizPreview({
    required this.quizId,
    required this.title,
    required this.description,
    required this.ready,
  });

  factory QuizPreview.fromJson(json) {
    return QuizPreview(
      quizId: json['id'],
      title: json['name'],
      // description: json['description'],
      description: 'Description',
      ready: json['ready'],
    );
  }
}
