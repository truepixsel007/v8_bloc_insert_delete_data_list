import 'package:equatable/equatable.dart';

abstract class ToDoEvent extends Equatable {
  ToDoEvent();
}

class AddTodoEvent extends ToDoEvent {
  final String task;
  AddTodoEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

class RemoveToDoEvent extends ToDoEvent {
  final Object task;
  RemoveToDoEvent({required this.task});

  @override
  List<Object?> get props => [task];
}
