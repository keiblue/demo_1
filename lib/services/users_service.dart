import 'dart:async';
import 'dart:convert';

import 'package:demo_1/models/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<List<User>> getUsers() async {
    List<User> users = [];
    final response =
        await http.get(Uri.https("jsonplaceholder.typicode.com", "users"));
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData) {
        users.add(
            User(item["id"], item["name"], item["username"], item["email"]));
      }
    } else {
      throw Exception("fallo el request");
    }
    return users;
  }

  Future<List<User>> getUsers2() async {
    final response =
        await http.get(Uri.https("jsonplaceholder.typicode.com", "users"));
    if (response.statusCode == 200) {
      final body = json.decode(utf8.decode(response.bodyBytes)) as List;
      return body.map((dynamic item) {
        return User(item["id"], item["name"], item["username"], item["email"]);
      }).toList();
    } else {
      throw Exception("fallo el request");
    }
  }

  Future<User?> postUser(String name, String username, String email) async {
    var client = http.Client();
    User user;
    try {
      var response = await http.post(
          Uri.https("jsonplaceholder.typicode.com", "users"),
          body: {"name": name, "username": username, "email": email});
      if (response.statusCode == 201) {
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);
        user = User(jsonData["id"], jsonData["name"], jsonData["username"],
            jsonData["email"]);
        print(user.toString());
        return user;
      }
    } on TimeoutException catch (e) {
      e.message;
      print("Tardo mucho la conexion");
    } on Error catch (e) {
      print("Error en la conexcion " + e.stackTrace.toString());
    } finally {
      client.close();
    }
  }
}
