import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:todolistbloc/app/model/todo_model.dart';
import 'package:todolistbloc/app/service/register/register_todo_service.dart';

const String url =
    'https://crudcrud.com/api/28c6b4e144f245639537821a3acca59b/todos';

class RegisterTodoServiceImpl implements RegisterTodoService {
  @override
  Future<Response> registerTodo({required TodoModel todoModel}) async {
    final body = {
      'titulo': todoModel.titulo,
      'descricao': todoModel.descricao,
      'prioridade': todoModel.prioridade,
    };

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await Dio().post(
      url,
      options: Options(headers: headers),
      data: jsonEncode(body),
    );
    if (response.statusCode == 201) {
      return response;
    } else {
      throw Exception(
          'Erro no retorno da api, status code: ${response.statusCode}');
    }
  }
}
