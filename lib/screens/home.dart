import 'package:flutter/material.dart';
import 'package:to_do_list/constants/colors.dart';
import 'package:to_do_list/model/todo.dart';
import 'package:to_do_list/widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<ToDo> todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final TextEditingController _todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _foundToDo = todosList;
  }

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
      _foundToDo.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    if (toDo.trim().isEmpty) return;

    setState(() {
      final newTodo = ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo.trim(),
      );
      todosList.insert(0, newTodo);
      _foundToDo = List.from(todosList);
    });
    _todoController.clear();
    FocusScope.of(context).unfocus();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) =>
              (item.todoText ?? '')
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                _searchBox(),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 90),
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 20),
                        child: const Text(
                          'All ToDos',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: tdBlack,
                          ),
                        ),
                      ),
                      if (_foundToDo.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Center(
                            child: Text(
                              'Tidak ada to-do yang ditemukan.',
                              style: TextStyle(fontSize: 16, color: tdGrey),
                            ),
                          ),
                        )
                      else
                        for (ToDo todo in _foundToDo)
                          ToDoItem(
                            todo: todo,
                            onToDoChanged: _handleToDoChange,
                            onDeleteItem: _deleteToDoItem,
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 15,
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
                          color: Colors.black12,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                        hintText: 'Tambah to-do baru...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) => _addToDoItem(value),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _addToDoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Cari tugas...',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          CircleAvatar(
            backgroundColor: tdBlue,
            radius: 20,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
