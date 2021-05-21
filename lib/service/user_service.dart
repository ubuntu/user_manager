import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:user_manager/model/user.dart';

class UserService {
  UserService({required this.uri});

  final String uri;

  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.http(uri, 'users'));

    if (response.statusCode == 200) {
      var usersJson = jsonDecode(response.body.toString()) as List;
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception(response.statusCode.toString() + ': ' + response.body);
    }
  }

  Future saveUser(User user) async {
    for (var aUser in await getUsers()) {
      if (aUser.id == user.id) {
        await updateUser(user);
        return;
      }
    }
    await addUser(user);
  }

  Future<http.Response> addUser(User user) async {
    return await http.post(Uri.http(uri, 'users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()));
  }

  Future updateUser(User user) async {
    return await http.put(Uri.http(uri, 'users/${user.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()));
  }

  Future removeUser(User user) async {
    await http.delete((Uri.http(uri, 'users/${user.id}')));
  }
}
