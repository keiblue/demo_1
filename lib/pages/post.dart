import 'package:flutter/material.dart';
import 'package:demo_1/services/users_service.dart' as userservice;

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final userService = userservice.UserService();
  final usuario = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(50.0),
              child: const Text("New User"),
            ),
            TextField(
              controller: usuario,
              decoration: const InputDecoration(hintText: "Nombre"),
            ),
            TextField(
              controller: username,
              decoration: const InputDecoration(hintText: "Nombre usuario"),
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(hintText: "Email"),
            ),
            Center(
              child: TextButton(
                  child: const Text('Registrar'),
                  onPressed: () {
                    _registrar(usuario.text, username.text, email.text);
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Back"),
        icon: const Icon(Icons.arrow_back),
        onPressed: () => {Navigator.pop(context)},
      ),
    );
  }

  _registrar(String name, String username, String email) {
    try {
      userService.postUser(name, username, email);
    } finally {
      _showInfo(context);
    }
  }

  _showInfo(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Informacion Usuario"),
        content: const Text("Se agrego usuario con exito"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cerrar"),
          ),
        ],
      ),
    );
  }
}
