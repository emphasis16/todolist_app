import '../models/todo_model.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ToDoModel> toDoListModel = ToDoModel.toDoList();
  final _newItemController = TextEditingController();
  List<ToDoModel> _foundTodo = [];

  @override
  void initState() {
    _foundTodo = toDoListModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBgColor,
      appBar: _appBarBuilder(),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 120,
              right: 20,
              left: 20,
            ),
            children: [
              _searchBar(),
              Container(
                margin: const EdgeInsets.only(top: 32, bottom: 16),
                child: const Text(
                  'All ToDos',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              for (ToDoModel toDoItem in _foundTodo.reversed)
                ListTileToDoItem(
                  toDoData: toDoItem,
                  onIsDoneChanged: _handleIsDoneChange,
                  onDeleteItem: _handleDeleteItem,
                ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 0),
                  blurRadius: 10,
                  spreadRadius: 0,
                ),
              ]),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                        right: 20,
                        left: 20,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 0),
                            blurRadius: 10,
                            spreadRadius: 0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _newItemController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Add a new to do item',
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _addToDoItem(_newItemController.text);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                        right: 20,
                      ),
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: tdBlue,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<ToDoModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = toDoListModel;
    } else {
      results = toDoListModel
          .where(
            (item) => item.todoText.toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ),
          )
          .toList();
    }
    setState(() {
      _foundTodo = results;
    });
  }

  void _handleIsDoneChange(ToDoModel toDoModel) {
    setState(() {
      toDoModel.isDone = !toDoModel.isDone;
    });
  }

  void _handleDeleteItem(String id) {
    setState(() {
      toDoListModel.removeWhere((toDoModelItem) => toDoModelItem.id == id);
    });
  }

  void _addToDoItem(String toDoText) {
    setState(() {
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      toDoListModel.add(
        ToDoModel(
          id: id,
          todoText: toDoText,
        ),
      );
      _newItemController.clear();
    });
  }

  Container _searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 32,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _appBarBuilder() {
    return AppBar(
      backgroundColor: tdBgColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/avatar.jpeg'),
            ),
          )
        ],
      ),
    );
  }
}
