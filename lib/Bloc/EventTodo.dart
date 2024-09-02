 import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}
class AddTodo extends TodoEvent{
  final String todo;
  const AddTodo(this.todo);
  @override
  List<Object?> get props => [todo];
}
class MarkTodoCompleted extends TodoEvent{
  final int index;
  const MarkTodoCompleted(this.index);
  @override
  List<Object?> get props => [index];
}

class DeleteTodo extends TodoEvent{
   final int index;

   const DeleteTodo(this.index);

   @override
   List<Object?> get props => [index];
}
class LoadTodos extends TodoEvent{}