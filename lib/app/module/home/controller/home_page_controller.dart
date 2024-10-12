import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolistbloc/app/model/todo_model.dart';
import 'package:todolistbloc/app/service/home/home_page_service.dart';

part 'home_page_state.dart';

class HomePageController extends Cubit<HomePageState> {
  final HomePageService _homePageService;

  HomePageController({required HomePageService homePageService})
      : _homePageService = homePageService,
        super(HomePageState.initial());

  Future<void> todoList() async {
    List<TodoModel> todoListaAbertas = [];
    try {
      emit(state.copyWith(status: HomePageStatus.loading));
      var todoList = await _homePageService.findTodo();

      for (var f in todoList) {
        if (f.status == 'Aberto') {
          todoListaAbertas.add(f);
        }
      }

      emit(
        state.copyWith(
          status: HomePageStatus.complete,
          todoModel: todoListaAbertas,
        ),
      );
    } catch (e, s) {
      emit(state.copyWith(
        status: HomePageStatus.failure,
        errorMessage: "Erro ao consultar tarefas - $s",
      ));
    }
  }

  Future<void> todoListExecucao() async {
    List<TodoModel> todoListExecucao = [];
    try {
      emit(state.copyWith(status: HomePageStatus.loading));
      var todoList = await _homePageService.findTodo();

      for (var f in todoList) {
        if (f.status == 'Em execução') {
          todoListExecucao.add(f);
        }
      }

      emit(
        state.copyWith(
          status: HomePageStatus.complete,
          todoModel: todoListExecucao,
        ),
      );
    } catch (e, s) {
      emit(state.copyWith(
        status: HomePageStatus.failure,
        errorMessage: "Erro ao consultar tarefas - $s",
      ));
    }
  }

  Future<void> todoListFechadas() async {
    List<TodoModel> todoListFechadas = [];
    try {
      emit(state.copyWith(status: HomePageStatus.loading));
      var todoList = await _homePageService.findTodo();

      for (var f in todoList) {
        if (f.status == 'Fechado') {
          todoListFechadas.add(f);
        }
      }

      emit(
        state.copyWith(
          status: HomePageStatus.complete,
          todoModel: todoListFechadas,
        ),
      );
    } catch (e, s) {
      emit(state.copyWith(
        status: HomePageStatus.failure,
        errorMessage: "Erro ao consultar tarefas - $s",
      ));
    }
  }

  Future<void> deleteTodo({required String id}) async {
    try {
      emit(state.copyWith(status: HomePageStatus.loading));
      await _homePageService.deleteTodo(id: id);

      emit(
        state.copyWith(
          status: HomePageStatus.complete,
        ),
      );
    } catch (e, s) {
      emit(state.copyWith(
        status: HomePageStatus.failure,
        errorMessage: "Erro ao consultar tarefas - $s",
      ));
    }
  }
}
