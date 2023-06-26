class Option {
  final int id;
  final String text;

  const Option({required this.id, required this.text});

  factory Option.fromJson(json){
    return Option(id: json['id'], text: json['text'].toString());
  }
}