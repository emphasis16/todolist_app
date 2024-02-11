import 'package:do_it/models/todo_model.dart';

import '../constants/colors.dart';
import 'package:flutter/material.dart';

class ListTileToDoItem extends StatelessWidget {
  const ListTileToDoItem({
    super.key,
    required this.toDoData,
    required this.onIsDoneChanged,
    required this.onDeleteItem,
  });
  final ToDoModel toDoData;
  final Function onIsDoneChanged;
  final Function onDeleteItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 4,
        ),
        onTap: () {
          onIsDoneChanged(toDoData);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: toDoData.isDone
            ? const Icon(
                Icons.check_box,
                color: tdBlue,
              )
            : const Icon(
                Icons.check_box_outline_blank,
                color: tdBlue,
              ),
        title: Text(
          toDoData.todoText,
          style: TextStyle(
            fontSize: 16,
            color: tdBlack,
            decoration: toDoData.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: GestureDetector(
          onTap: () {
            onDeleteItem(toDoData.id);
          },
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: tdRed,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Icon(
              Icons.delete,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
