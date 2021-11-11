import 'package:flutter/material.dart';
import 'package:demo_1/models/user.dart';
import 'package:demo_1/services/users_service.dart' as userservice;

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
      body: usersWidget(),
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
                      _deleteUser(context, snapshot.data[index]);
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

  _deleteUser(context, User user) {
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
