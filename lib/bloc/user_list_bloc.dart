import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:demo_1/services/users_service.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc() : super(UserListInitial()) {
    on<UserListEvent>((event, emit) {
      // TODO: implement event handler
    });

    Future<void> _onUserFetched(
        UserListEvent event, Emitter<UserListEvent> emit) async {}
  }
}
