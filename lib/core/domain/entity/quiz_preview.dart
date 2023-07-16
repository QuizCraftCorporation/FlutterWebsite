class QuizPreview {
  final int quizId;
  final String title;
  final String description;
  final bool ready;
  final bool private;

  const QuizPreview({
    required this.quizId,
    required this.title,
    required this.description,
    required this.ready,
    required this.private,
  });

  factory QuizPreview.fromJson(json) {
    return QuizPreview(
      quizId: json['id'],
      title: json['name'],
      description: json['description'],
      // description: 'Description',
      ready: json['ready'],
      private: json['private'],
    );
  }
}
