import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolistbloc/app/module/register/controller/register_todo_controller.dart';
import 'package:todolistbloc/app/module/register/register_todo_page.dart';
import 'package:todolistbloc/app/service/register/register_todo_service.dart';
import 'package:todolistbloc/app/service/register/register_todo_service_impl.dart';

class RegisterTodoPageModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<RegisterTodoController>(RegisterTodoController.new);
    i.addLazySingleton<RegisterTodoService>(RegisterTodoServiceImpl.new);
  }

  @override
  void routes(r) {
    [
      r.child(
        '/',
        child: (context) => RegisterTodoPage(
          controller: Modular.get<RegisterTodoController>(),
        ),
      ),
    ];
  }
}
