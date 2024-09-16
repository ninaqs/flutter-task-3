class Note {
  String title;
  String details;

  Note({
    required this.title,
    required this.details,
  });

  //converting Note objects to Maps to save and load from box otherwise there'd be an error
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'details': details,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'],
      details: map['details'],
    );
  }
}
