import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolistbloc/app/model/todo_model.dart';
import 'package:todolistbloc/app/module/home/controller/home_page_controller.dart';
import 'package:todolistbloc/app/module/home/widgets/home_page_abertas.dart';
import 'package:todolistbloc/app/module/home/widgets/home_page_execucao.dart';
import 'package:todolistbloc/app/module/home/widgets/home_page_fechadas.dart';

class HomePage extends StatefulWidget {
  final HomePageController controller;
  const HomePage({super.key, required this.controller});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    widget.controller.todoList();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  TodoModel todo = TodoModel();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomePageController, HomePageState>(
      bloc: widget.controller,
      listener: (context, state) {
        if (state.status == HomePageStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                'Falha na busca de tarefas. Tente novamente!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('To-Do-List'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Abertas'),
              Tab(text: 'Em Execução'),
              Tab(text: 'Fechadas'),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Modular.to.pushNamed('register');
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Column(
          children: [
            BlocSelector<HomePageController, HomePageState, bool>(
              bloc: widget.controller,
              selector: (state) => state.status == HomePageStatus.loading,
              builder: (context, loading) {
                return Visibility(
                  visible: loading,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  HomePageAbertas(controller: widget.controller),
                  HomePageExecucao(controller: widget.controller),
                  HomePageFechadas(controller: widget.controller),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
