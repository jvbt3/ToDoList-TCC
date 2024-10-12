import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolistbloc/app/model/todo_model.dart';
import 'package:todolistbloc/app/module/update/controller/update_todo_controller.dart';
import 'package:todolistbloc/app/module/update/update_todo_page.dart';
import 'package:todolistbloc/app/service/update/update_todo_service.dart';
import 'package:todolistbloc/app/service/update/update_todo_service_impl.dart';

class UpdateTodoModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<UpdateTodoController>(UpdateTodoController.new);
    i.addLazySingleton<UpdateTodoService>(UpdateTodoServiceImpl.new);
  }

  @override
  void routes(r) {
    [
      r.child(
        '/',
        child: (context) => UpdateTodoPage(
          todoModel: Modular.args.data as TodoModel,
          controller: Modular.get<UpdateTodoController>(),
        ),
      ),
    ];
  }
}
