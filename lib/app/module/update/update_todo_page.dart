import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolistbloc/app/model/todo_model.dart';
import 'package:todolistbloc/app/module/update/controller/update_todo_controller.dart';

const List<String> listPrioridade = <String>['Baixa', 'Média', 'Alta'];
const List<String> listStatus = <String>['Aberto', 'Em execução', 'Fechado'];

class UpdateTodoPage extends StatefulWidget {
  final UpdateTodoController controller;
  final TodoModel todoModel;

  const UpdateTodoPage({
    super.key,
    required this.controller,
    required this.todoModel,
  });

  @override
  State<UpdateTodoPage> createState() => _UpdateTodoPageState();
}

class _UpdateTodoPageState extends State<UpdateTodoPage> {
  late TextEditingController tituloController;
  late TextEditingController descricaoController;
  final _formKey = GlobalKey<FormState>();
  late String dropdownValueS;
  late String dropdownValueP;

  @override
  void initState() {
    super.initState();
    tituloController = TextEditingController(text: widget.todoModel.titulo);
    descricaoController =
        TextEditingController(text: widget.todoModel.descricao);

    // Atribui um valor padrão que é um item existente na lista
    dropdownValueP = listPrioridade.contains(widget.todoModel.prioridade)
        ? widget.todoModel.prioridade!
        : listPrioridade
            .first; // Use o primeiro item como padrão se não existir

    dropdownValueS = listStatus.contains(widget.todoModel.status)
        ? widget.todoModel.status!
        : listStatus.first; // Use o primeiro item como padrão se não existir
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Atualizar Tarefa')),
      body: BlocListener<UpdateTodoController, UpdateTodoState>(
        bloc: widget.controller,
        listener: (context, state) async {
          if (state.status == UpdateTodoStatus.complete) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tarefa atualizada com sucesso!'),
                backgroundColor: Colors.green,
              ),
            );
            Modular.to.popAndPushNamed('/home');
          } else if (state.status == UpdateTodoStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Falha ao atualizar a tarefa!'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<UpdateTodoController, UpdateTodoState>(
          bloc: widget.controller,
          builder: (context, state) {
            return Center(
              child: SizedBox(
                width: 500,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: tituloController,
                        decoration: const InputDecoration(
                          labelText: 'Título',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Insira o título da tarefa';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: descricaoController,
                        decoration: const InputDecoration(
                          labelText: 'Descrição',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Insira a descrição da tarefa';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: dropdownValueP,
                        items: listPrioridade
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValueP = value!;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Prioridade',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: dropdownValueS,
                        items: listStatus
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValueS = value!;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Status',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: state.status == UpdateTodoStatus.loading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  widget.todoModel.titulo =
                                      tituloController.text;
                                  widget.todoModel.descricao =
                                      descricaoController.text;
                                  widget.todoModel.prioridade = dropdownValueP;
                                  widget.todoModel.status = dropdownValueS;

                                  widget.controller
                                      .updateTodo(todoModel: widget.todoModel);
                                }
                              },
                        child: state.status == UpdateTodoStatus.loading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text('Salvar'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
