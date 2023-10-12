class TaskModel {
  String id;
  String title;
  String description;
  int date;
  bool isDone;

  TaskModel({
    this.id="",
    required this.title,
    required this.description,
    required this.date,
    this.isDone = false});

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          date: json['date'],
          description: json['description'],
          isDone: json['isDone'],
          title: json['title'],
        );

  Map<String,dynamic> toJson (){
    return {
      "id":id,
      "description":description,
      "date":date,
      "isDone":isDone,
      "title":title,

    };
  }
}
