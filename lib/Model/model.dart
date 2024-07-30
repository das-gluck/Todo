
class Note {
  String? title ;
  // int? priority ;
  Note({this.title});

  factory Note.fromJson(Map<String,dynamic> json) => Note(
    title: json['title'],
    // priority: json['priority'],
  );

  Map<String , dynamic> toJson() => {
    'title' : title,
    // 'priority' : priority,
  };
}