class Note {
  final int id;
  final String title;
  final String content;

  Note({
    required this.id,
    required this.title,
    required this.content,
  });

  // Method to convert a Note object into a JSON object (Map<String, dynamic>)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }

  // Factory constructor to create a Note object from a JSON object (Map<String, dynamic>)
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }

  // Copying method to update specific fields immutably
  Note copyWith({int? id, String? title, String? content}) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }
}