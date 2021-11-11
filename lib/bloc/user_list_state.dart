part of 'user_list_bloc.dart';

@immutable
abstract class UserListState {}

class UserListInitial extends UserListState {}

class UserListInProgress extends UserListState {}

class UserListFailure extends UserListState {
  UserListFailure({this.menssage});

  final String? menssage;
}

class UserListSuccess extends UserListState {}
