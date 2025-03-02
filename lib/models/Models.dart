class Models{
  String title;
  String description;
  DateTime createdTime = DateTime.now();
  DateTime? updatedTime;

  Models(
      {required this.title, required this.description, required this.createdTime, required this.updatedTime,
      });
}