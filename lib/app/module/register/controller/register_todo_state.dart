// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_todo_controller.dart';

enum RegisterTodoStatus { initial, loading, complete, failure }

class RegisterTodoState extends Equatable {
  final RegisterTodoStatus status;
  final String? errorMessage;

  const RegisterTodoState._({
    required this.status,
    this.errorMessage,
  });

  const RegisterTodoState.initial()
      : this._(
          status: RegisterTodoStatus.initial,
        );

  @override
  List<Object?> get props => [
        status,
        errorMessage,
      ];

  RegisterTodoState copyWith({
    RegisterTodoStatus? status,
    String? errorMessage,
  }) {
    return RegisterTodoState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
