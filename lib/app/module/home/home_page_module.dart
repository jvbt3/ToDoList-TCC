import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolistbloc/app/module/home/controller/home_page_controller.dart';
import 'package:todolistbloc/app/module/home/home_page.dart';
import 'package:todolistbloc/app/module/register/register_todo_page_module.dart';
import 'package:todolistbloc/app/module/update/update_todo_module.dart';
import 'package:todolistbloc/app/service/home/home_page_service.dart';
import 'package:todolistbloc/app/service/home/home_page_service_impl.dart';

class HomePageModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<HomePageController>(HomePageController.new);
    i.addLazySingleton<HomePageService>(HomePageServiceImpl.new);
  }

  @override
  void routes(r) {
    [
      r.child(
        '/',
        child: (context) => HomePage(
          controller: Modular.get<HomePageController>(),
        ),
      ),
      r.module(
        '/register',
        module: RegisterTodoPageModule(),
      ),
      r.module(
        '/update',
        module: UpdateTodoModule(),
      )
    ];
  }
}
