import 'package:dio/dio.dart';
import 'package:todolistbloc/app/model/todo_model.dart';
import 'package:todolistbloc/app/service/home/home_page_service.dart';

const String url =
    'https://crudcrud.com/api/28c6b4e144f245639537821a3acca59b/todos';

class HomePageServiceImpl implements HomePageService {
  @override
  Future<List<TodoModel>> findTodo() async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await Dio().get(
      url,
      options: Options(headers: headers),
    );
    if (response.statusCode == 200) {
      List<dynamic> responseData = response.data as List<dynamic>;
      List<TodoModel> todoModel = TodoModel.fromJsonList(
          responseData.map((item) => item as Map<String, dynamic>).toList());

      return todoModel;
    } else {
      throw Exception(
          'Erro no retorno da api, status code: ${response.statusCode}');
    }
  }

  @override
  Future<Response> deleteTodo({required String id}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await Dio().delete(
      '$url/$id',
      options: Options(headers: headers),
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception(
          'Erro no retorno da api, status code: ${response.statusCode}');
    }
  }
}
