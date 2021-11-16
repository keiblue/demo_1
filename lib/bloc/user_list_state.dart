part of 'user_list_bloc.dart';

class UserListState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserListInitial extends UserListState {}

class UserListLoaded extends UserListState {
  final List<User> users;
  UserListLoaded({required this.users});
}

class UserListFailure extends UserListState {
  UserListFailure({required this.error});
  final String error;
}

class UserListSuccess extends UserListState {}

class UserListDeleted extends UserListState {
  UserListDeleted({required this.user});
  final User user;
}
