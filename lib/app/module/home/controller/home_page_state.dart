// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_page_controller.dart';

enum HomePageStatus { initial, loading, complete, failure }

class HomePageState extends Equatable {
  final List<TodoModel> todoModel;
  final HomePageStatus status;
  final String? errorMessage;

  const HomePageState._({
    required this.status,
    required this.todoModel,
    this.errorMessage,
  });

  HomePageState.initial()
      : this._(
          todoModel: [],
          status: HomePageStatus.initial,
        );

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        todoModel,
      ];

  HomePageState copyWith({
    HomePageStatus? status,
    String? errorMessage,
    List<TodoModel>? todoModel,
  }) {
    return HomePageState._(
      todoModel: todoModel ?? this.todoModel,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
