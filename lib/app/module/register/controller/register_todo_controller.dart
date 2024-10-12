import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolistbloc/app/model/todo_model.dart';
import 'package:todolistbloc/app/service/register/register_todo_service.dart';

part 'register_todo_state.dart';

class RegisterTodoController extends Cubit<RegisterTodoState> {
  final RegisterTodoService _registerTodoService;

  RegisterTodoController({required RegisterTodoService registerTodoService})
      : _registerTodoService = registerTodoService,
        super(const RegisterTodoState.initial());

  Future<void> registerTodo({required TodoModel todoModel}) async {
    try {
      emit(state.copyWith(status: RegisterTodoStatus.loading));
      await _registerTodoService.registerTodo(todoModel: todoModel);

      emit(
        state.copyWith(
          status: RegisterTodoStatus.complete,
        ),
      );
    } catch (e, s) {
      emit(state.copyWith(
        status: RegisterTodoStatus.failure,
        errorMessage: "Erro ao criar tarefas - $s",
      ));
    }
  }
}
