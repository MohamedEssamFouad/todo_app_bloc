import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/BlocTodo.dart';
import 'Bloc/EventTodo.dart';
import 'Bloc/StatesTodo.dart';

class TodoListScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoBloc = BlocProvider.of<TodoBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter new todo',
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  todoBloc.add(AddTodo(value));
                  _controller.clear();
                }
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is TodosLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TodosLoaded) {
                  return ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
                      return ListTile(
                        title: Text(
                          todo.task,
                          style: TextStyle(
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        leading: Checkbox(
                          value: todo.isCompleted,
                          onChanged: (_) {
                            todoBloc.add(MarkTodoCompleted(index));
                          },
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            todoBloc.add(DeleteTodo(index));
                          },
                        ),
                      );
                    },
                  );
                } else if (state is TodosError) {
                  return Center(child: Text(state.errorMessage));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
