import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolistbloc/app/model/todo_model.dart';
import 'package:todolistbloc/app/module/home/controller/home_page_controller.dart';

class HomePage extends StatefulWidget {
  final HomePageController controller;
  const HomePage({super.key, required this.controller});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget.controller.todoList();
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
              child: BlocBuilder<HomePageController, HomePageState>(
                bloc: widget.controller,
                builder: (context, state) {
                  if (state.status == HomePageStatus.complete &&
                      state.todoModel.isNotEmpty) {
                    return ListView.builder(
                      itemCount: state.todoModel.length,
                      itemBuilder: (context, index) {
                        todo = state.todoModel[index];
                        return Card(
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Título: ${todo.titulo}'),
                                    Text('Descrição: ${todo.descricao}'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () async {
                                        final todo = state.todoModel[index];
                                        Modular.to.pushNamed(
                                          'update',
                                          arguments: todo,
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () async {
                                        await widget.controller.deleteTodo(
                                            id: state.todoModel[index].id!);
                                        await widget.controller.todoList();
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Text(
                              'Prioridade: ${state.todoModel[index].prioridade!}',
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state.status == HomePageStatus.complete &&
                      state.todoModel.isEmpty) {
                    return const Center(
                      child: Text('Nenhum item na lista.'),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
