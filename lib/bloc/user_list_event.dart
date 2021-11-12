part of 'user_list_bloc.dart';

abstract class UserListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// aqui se agregan y definen los eventos
class UserListDeleted extends UserListEvent {
  UserListDeleted({required this.user});
  final User user;
}

class UserListFetched extends UserListEvent {}

class UserListShow extends UserListEvent {}
