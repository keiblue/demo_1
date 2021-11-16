import 'package:demo_1/bloc/user_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:demo_1/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetPage extends StatefulWidget {
  const GetPage({Key? key}) : super(key: key);

  @override
  State<GetPage> createState() => _GetPageState();
}

class _GetPageState extends State<GetPage> {
  UserListBloc userbloc = UserListBloc();
  GlobalKey<ScaffoldMessengerState> messengerState =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: messengerState,
      child: Scaffold(
        body: BlocProvider(
          create: (context) => userbloc..add(UserListFetched()),
          child: usersWidgetbloc(),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text("Back"),
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
    );
  }

  Widget usersWidgetbloc() {
    return BlocBuilder<UserListBloc, UserListState>(
      builder: (BuildContext context, UserListState state) {
        if (state is UserListFailure) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is UserListLoaded) {
          var users = state.users;
          return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(users[index].name),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      messengerState.currentState!
                          .showSnackBar(const SnackBar(content: Text("Hecho")));
                      _deleteUser2(context, users[index], userbloc);
                    }
                    if (direction == DismissDirection.endToStart) {
                      messengerState.currentState!.showSnackBar(
                          const SnackBar(content: Text("Eliminado")));
                      _deleteUser2(context, users[index], userbloc);
                    }
                  },
                  background: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20.0),
                    color: Colors.redAccent,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    color: Colors.orangeAccent,
                    child: const Icon(Icons.edit, color: Colors.white),
                  ),
                  child: ListTile(
                    onLongPress: () {
                      _deleteUser(context, users[index], userbloc);
                    },
                    title: Text(users[index].name),
                    subtitle: Text("UserName: " +
                        users[index].username +
                        "\nEmail: " +
                        users[index].email),
                    leading: CircleAvatar(
                      child: Text(
                        users[index].name.substring(0, 1),
                      ),
                    ),
                    trailing: const Icon(Icons.menu),
                  ),
                );
              });
        }
        if (state is UserListDeleted) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _deleteUser(context, User user, UserListBloc blocprob) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Eliminar Usuario"),
        content:
            Text("Estas seguro que quieres eliminar a " + user.username + "?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              blocprob.add(DeleteUser(user: user));
              setState(() {});
              Navigator.pop(context);
            },
            child: const Text(
              "Borrar",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _deleteUser2(context, User user, UserListBloc blocprob) {
    blocprob.add(DeleteUser(user: user));
    setState(() {});
  }
}
