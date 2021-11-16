import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:demo_1/models/user.dart';
import 'package:demo_1/services/users_service.dart' as userservice;
import 'package:equatable/equatable.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  List<User> users = [];
  final userService = userservice.UserService();
  UserListBloc() : super(UserListInitial());

  @override
  Stream<UserListState> mapEventToState(UserListEvent event) async* {
    if (event is UserListFetched) {
      yield UserListInitial();
      try {
        users = await userService.getUsers();
        yield UserListLoaded(users: users);
      } catch (e) {
        yield UserListFailure(error: 'Unknown Error');
      }
    }
    if (event is DeleteUser) {
      User user = event.user;
      users.remove(user);
      yield UserListLoaded(users: users);
    }
  }
}
