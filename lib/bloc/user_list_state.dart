part of 'user_list_bloc.dart';

enum UserListStatus { initial, progress, failure, success, deleted }

class UserListState extends Equatable {
  const UserListState({
    this.status = UserListStatus.initial,
    this.users = const <User>[],
  });

  final UserListStatus status;
  final List<User> users;

  UserListState copyWith({UserListStatus? status, List<User>? users}) {
    return UserListState(
        status: status ?? this.status, users: users ?? this.users);
  }

  @override
  String toString() {
    return '''UserListState { status: $status, users: ${users.length} }''';
  }

  @override
  List<Object> get props => [status, users];
}
