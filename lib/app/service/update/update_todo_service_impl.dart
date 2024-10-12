import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:todolistbloc/app/model/todo_model.dart';
import 'package:todolistbloc/app/service/update/update_todo_service.dart';

const String url =
    'https://crudcrud.com/api/1a82d204e1ee4088a50905b4d97cdd3c/todos';

class UpdateTodoServiceImpl implements UpdateTodoService {
  @override
  Future<Response> updateTodo({required TodoModel todoModel}) async {
    final body = {
      'titulo': todoModel.titulo,
      'descricao': todoModel.descricao,
      'prioridade': todoModel.prioridade,
      'status': todoModel.status
    };

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await Dio().put(
      '$url/${todoModel.id}',
      options: Options(headers: headers),
      data: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception(
          'Erro no retorno da api, status code: ${response.statusCode}');
    }
  }
}
