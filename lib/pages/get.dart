import 'package:demo_1/bloc/user_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:demo_1/models/user.dart';
import 'package:demo_1/services/users_service.dart' as userservice;
import 'package:flutter_bloc/flutter_bloc.dart';

class GetPage extends StatefulWidget {
  const GetPage({Key? key}) : super(key: key);

  @override
  State<GetPage> createState() => _GetPageState();
}

class _GetPageState extends State<GetPage> {
  var userService = userservice.UserService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => UserListBloc(),
        child: usersWidgetbloc(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Back"),
        icon: const Icon(Icons.arrow_back),
        onPressed: () => {Navigator.pop(context)},
      ),
    );
  }

  Widget usersWidget() {
    return FutureBuilder(
        future: userService.getUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onLongPress: () {
                      _deleteUser2(context, snapshot.data[index]);
                    },
                    title: Text(snapshot.data[index].name),
                    subtitle: Text("UserName: " +
                        snapshot.data[index].username +
                        "\nEmail: " +
                        snapshot.data[index].email),
                    leading: CircleAvatar(
                      child: Text(
                        snapshot.data[index].name.substring(0, 1),
                      ),
                    ),
                    trailing: const Icon(Icons.menu),
                  );
                });
          }
        });
  }

  Widget usersWidgetbloc() {
    return BlocBuilder<UserListBloc, UserListState>(
      builder: (context, state) {
        switch (state.status) {
          case UserListStatus.initial:
            BlocProvider.of<UserListBloc>(context).add(UserListFetched());
            return const Center(child: CircularProgressIndicator());
          case UserListStatus.failure:
            return const Center(child: Text('fallo en traer usuarios'));
          case UserListStatus.success:
            if (state.users.isEmpty) {
              return const Center(child: Text('no Users'));
            }
            var users = state.users;
            UserListBloc blocProb = BlocProvider.of<UserListBloc>(context);
            return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onLongPress: () {
                      _deleteUser(context, users[index], blocProb);
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
                  );
                });
          case UserListStatus.deleted:
            BlocProvider.of<UserListBloc>(context).add(UserListShow());
            return const Center(child: CircularProgressIndicator());
          case UserListStatus.progress:
            return const Center(child: CircularProgressIndicator());
          default:
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
              blocprob.add(UserListDeleted(user: user));
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

  _deleteUser2(context, User user) {
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
}
