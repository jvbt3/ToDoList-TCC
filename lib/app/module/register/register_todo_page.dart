import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolistbloc/app/model/todo_model.dart';
import 'package:todolistbloc/app/module/register/controller/register_todo_controller.dart';

const List<String> list = <String>['Baixa', 'Média', 'Alta'];

class RegisterTodoPage extends StatefulWidget {
  final RegisterTodoController controller;
  const RegisterTodoPage({super.key, required this.controller});

  @override
  State<RegisterTodoPage> createState() => _RegisterTodoPageState();
}

class _RegisterTodoPageState extends State<RegisterTodoPage> {
  TextEditingController tituloController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = list.first;

  TodoModel todoModel = TodoModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Tarefa')),
      body: BlocListener<RegisterTodoController, RegisterTodoState>(
        bloc: widget.controller,
        listener: (context, state) async {
          if (state.status == RegisterTodoStatus.complete) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tarefa registrada com sucesso!'),
                backgroundColor: Colors.green,
              ),
            );
            Modular.to.popAndPushNamed('/home');
          } else if (state.status == RegisterTodoStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Falha ao registrar a tarefa!'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<RegisterTodoController, RegisterTodoState>(
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
                        value: dropdownValue,
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Prioridade',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: state.status == RegisterTodoStatus.loading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  todoModel.titulo = tituloController.text;
                                  todoModel.descricao =
                                      descricaoController.text;
                                  todoModel.prioridade = dropdownValue;

                                  widget.controller
                                      .registerTodo(todoModel: todoModel);
                                }
                              },
                        child: state.status == RegisterTodoStatus.loading
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
