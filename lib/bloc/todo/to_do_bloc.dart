import 'package:bloc/bloc.dart';
import 'package:v8_bloc_insert_delete_data_list/bloc/todo/to_do_event.dart';
import 'package:v8_bloc_insert_delete_data_list/bloc/todo/to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final List<String> todoList = [];

  ToDoBloc() : super(ToDoState()) {
    on<AddTodoEvent>(_addToDoEvent);
    on<RemoveToDoEvent>(_removeToDoEvent);
  }

  void _addToDoEvent(AddTodoEvent event, Emitter<ToDoState> emit) {
    todoList.add(event.task);
    emit(state.copyWith(todosList: List.from(todoList)));
  }

  void _removeToDoEvent(RemoveToDoEvent event, Emitter<ToDoState> emit) {
    todoList.remove(event.task);
    emit(state.copyWith(todosList: List.from(todoList)));
  }
}
