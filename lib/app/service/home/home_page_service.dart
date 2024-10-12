import 'package:dio/dio.dart';
import 'package:todolistbloc/app/model/todo_model.dart';

abstract class HomePageService {
  Future<List<TodoModel>> findTodo();

  Future<Response> deleteTodo({required String id});
}
