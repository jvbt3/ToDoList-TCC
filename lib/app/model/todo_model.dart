class TodoModel {
  String? id;
  String? titulo;
  DateTime? criacao;
  String? prioridade;
  String? descricao;
  String? status;
  TodoModel({
    this.id,
    this.titulo,
    this.criacao,
    this.prioridade,
    this.descricao,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'titulo': titulo,
      'criacao': criacao?.millisecondsSinceEpoch,
      'prioridade': prioridade,
      'descricao': descricao,
      'status': status
    };
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['_id'] != null ? json['_id'] as String : null,
      titulo: json['titulo'] != null ? json['titulo'] as String : null,
      criacao: json['criacao'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['criacao'] as int)
          : null,
      prioridade:
          json['prioridade'] != null ? json['prioridade'] as String : null,
      descricao: json['descricao'] != null ? json['descricao'] as String : null,
      status: json['status'] != null ? json['status'] as String : null,
    );
  }
  static List<TodoModel> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => TodoModel.fromJson(json)).toList();
  }
}
