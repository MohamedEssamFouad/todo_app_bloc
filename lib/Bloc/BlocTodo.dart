import 'package:flutter_bloc/flutter_bloc.dart';

import '../Todo.dart';
import 'EventTodo.dart';
import 'StatesTodo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodosLoading()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<MarkTodoCompleted>(_onMarkTodoCompleted);
    on<DeleteTodo>(_onDeleteTodo);
  }
  void _onLoadTodos(LoadTodos event,Emitter <TodoState>emit)async{
    emit(TodosLoading());
    await Future.delayed(const Duration(seconds: 2));
    final initialTodos=[
      Todo(task: 'Learn Flutter'),
      Todo(task: 'Build a Todo App'),
    ];
    emit(TodosLoaded(initialTodos));
  }
  void _onAddTodo(AddTodo event, Emitter<TodoState> emit) {
    if (state is TodosLoaded) {
      final currentState = state as TodosLoaded;
      final updatedTodos = List<Todo>.from(currentState.todos)
        ..add(Todo(task: event.todo));
      emit(TodosLoaded(updatedTodos));
    }
  }
  void _onMarkTodoCompleted(MarkTodoCompleted event, Emitter<TodoState> emit) {
    if (state is TodosLoaded) {
      final currentState = state as TodosLoaded;
      final updatedTodos = List<Todo>.from(currentState.todos);
      updatedTodos[event.index].isCompleted = !updatedTodos[event.index].isCompleted;
      emit(TodosLoaded(updatedTodos));
    }
  }
  void _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) {
    if (state is TodosLoaded) {
      final currentState = state as TodosLoaded;
      final updatedTodos = List<Todo>.from(currentState.todos)
        ..removeAt(event.index);
      emit(TodosLoaded(updatedTodos));
    }
  }

  }