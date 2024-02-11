class ToDoModel {
  String id;
  String todoText;
  bool isDone;

  ToDoModel({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDoModel> toDoList() {
    return [
      ToDoModel(id: '01', todoText: 'Morning Exercises', isDone: true),
      ToDoModel(id: '02', todoText: 'Buy Groceries', isDone: true),
      ToDoModel(id: '03', todoText: 'Check Emails'),
      ToDoModel(id: '04', todoText: 'Team Meeeting'),
      ToDoModel(id: '05', todoText: 'Work on mobile apps for 4 hours'),
      ToDoModel(id: '06', todoText: 'Dinner with family'),
    ];
  }
}
