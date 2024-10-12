// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'update_todo_controller.dart';

enum UpdateTodoStatus { initial, loading, complete, failure }

class UpdateTodoState extends Equatable {
  final UpdateTodoStatus status;
  final String? errorMessage;

  const UpdateTodoState._({
    required this.status,
    this.errorMessage,
  });

  const UpdateTodoState.initial()
      : this._(
          status: UpdateTodoStatus.initial,
        );

  @override
  List<Object?> get props => [
        status,
        errorMessage,
      ];

  UpdateTodoState copyWith({
    UpdateTodoStatus? status,
    String? errorMessage,
  }) {
    return UpdateTodoState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
