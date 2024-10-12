import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolistbloc/app/model/todo_model.dart';
import 'package:todolistbloc/app/module/home/controller/home_page_controller.dart';

class HomePageExecucao extends StatefulWidget {
  final HomePageController controller;
  const HomePageExecucao({super.key, required this.controller});

  @override
  State<HomePageExecucao> createState() => _HomePageExecucaoState();
}

class _HomePageExecucaoState extends State<HomePageExecucao>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.controller.todoListExecucao();
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
      child: Column(
        children: [
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Título: ${todo.titulo}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Descrição: ${todo.descricao}',
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
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
                                      await widget.controller
                                          .todoListExecucao();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          subtitle: Column(
                            children: [
                              Text(
                                'Prioridade: ${state.todoModel[index].prioridade!}',
                              ),
                              Text(
                                'Status: ${state.todoModel[index].status}',
                              ),
                            ],
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
    );
  }
}
