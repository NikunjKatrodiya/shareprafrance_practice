class ToDoModel {
  final String? title;
  final String? description;

  ToDoModel({this.title, this.description});
  ToDoModel.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String?,
        description = json['description'] as String?;

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
      };
}
