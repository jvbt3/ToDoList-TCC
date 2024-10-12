import 'package:dio/dio.dart';
import 'package:todolistbloc/app/model/todo_model.dart';

abstract class RegisterTodoService {
  Future<Response> registerTodo({
    required TodoModel todoModel,
  });
}
