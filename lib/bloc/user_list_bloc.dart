import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:demo_1/models/user.dart';
import 'package:demo_1/services/users_service.dart' as userservice;
import 'package:equatable/equatable.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc() : super(const UserListState()) {
    on<UserListFetched>(_onUserFetched);
    on<UserListDeleted>(_onUserDeleted);
    on<UserListShow>(_onUserShow);
  }

  final userService = userservice.UserService();

  FutureOr<void> _onUserFetched(
      UserListFetched event, Emitter<UserListState> emit) async {
    try {
      if (state.status == UserListStatus.initial) {
        final users = await userService.getUsers2();
        return emit(
            state.copyWith(status: UserListStatus.success, users: users));
      }
    } catch (_) {
      emit(state.copyWith(status: UserListStatus.failure));
    }
  }

  FutureOr<void> _onUserDeleted(
      UserListDeleted event, Emitter<UserListState> emit) async {
    List<User> newUsers = [];
    for (User user in state.users) {
      if (user != event.user) {
        newUsers.add(user);
      }
    }
    return emit(
        state.copyWith(status: UserListStatus.deleted, users: newUsers));
  }

  FutureOr<void> _onUserShow(
      UserListShow event, Emitter<UserListState> emit) async {
    return emit(
        state.copyWith(status: UserListStatus.success, users: state.users));
  }
}
