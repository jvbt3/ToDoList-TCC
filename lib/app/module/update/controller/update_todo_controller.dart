import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolistbloc/app/model/todo_model.dart';
import 'package:todolistbloc/app/service/update/update_todo_service.dart';

part 'update_todo_state.dart';

class UpdateTodoController extends Cubit<UpdateTodoState> {
  final UpdateTodoService _updateTodoService;

  UpdateTodoController({required UpdateTodoService updateTodoService})
      : _updateTodoService = updateTodoService,
        super(const UpdateTodoState.initial());

  Future<void> updateTodo({required TodoModel todoModel}) async {
    try {
      emit(state.copyWith(status: UpdateTodoStatus.loading));
      await _updateTodoService.updateTodo(todoModel: todoModel);

      emit(
        state.copyWith(
          status: UpdateTodoStatus.complete,
        ),
      );
    } catch (e, s) {
      emit(state.copyWith(
        status: UpdateTodoStatus.failure,
        errorMessage: "Erro ao atualizar tarefas - $s",
      ));
    }
  }
}
