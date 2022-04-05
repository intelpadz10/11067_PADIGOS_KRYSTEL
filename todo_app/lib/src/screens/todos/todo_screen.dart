import 'package:flutter/material.dart';
import 'package:todo_app/src/controllers/todo_controller.dart';
import 'package:todo_app/src/screens/todos/todo_model.dart';
import 'package:todo_app/src/screens/todos/widgets/input_widget.dart';
import 'package:todo_app/src/screens/todos/widgets/todo_card.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TodoController _todoController = TodoController();
  final ScrollController _sc = ScrollController();
  // bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos App'),
        backgroundColor: const Color.fromARGB(255, 117, 37, 216),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 118, 37, 216),
        child: const Icon(Icons.add),
        onPressed: () {
          showAddDialog(context);
        },
      ),
      backgroundColor: const Color.fromARGB(255, 245, 231, 255),
      
      body: SafeArea(
        child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
          child: AnimatedBuilder(
            animation: _todoController,
            builder: (context, Widget? w) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Scrollbar(
                        controller: _sc,
                        isAlwaysShown: true,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(12.0),
                          controller: _sc,
                          child: Column(
                            children: [
                              for (Todo todo in _todoController.data)
                                TodoCard(
                                  margin: const EdgeInsets.symmetric(vertical: 8),
                                  todo: todo,
                                  onTap: () {
                                    _todoController.toggleDone(todo);
                                  },
                                  onErase: () {
                                    _todoController.removeTodo(todo);
                                  },
                                  onLongPress: () {
                                    showEditDialog(context, todo);
                                  },
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  showAddDialog(BuildContext context) async {
    Todo? result = await showDialog<Todo>(
        context: context,
        builder: (dContext) {
          return const Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: InputWidget(),
          );
        });
    if (result != null) {
      _todoController.addTodo(result);
    }
  }

  showEditDialog(BuildContext context, Todo todo) async {
    Todo? result = await showDialog<Todo>(
        context: context,
        builder: (dContext) {
          return Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
            child: InputWidget(
              current: todo.details,
            ),
          );
        });
    if (result != null) {
      _todoController.updateTodo(todo, result.details);
    }
  }
}

// @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         body: ListView(
//           children: [],
//         ),
//   );

//   Widget buildCheckbox() =>
//       ListTile(
//         onTap: onClicked,
//         leading: Checkbox(
//           onChanged: (value) => onClicked(),
//         ),
//         title: Text(),
//       );