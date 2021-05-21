import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:user_manager/model/user.dart';
import 'package:user_manager/service/user_service.dart';
import 'package:user_manager/view/user_card.dart';
import 'package:user_manager/view/user_edit_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _nameController;
  final _userService = Injector.appInstance.get<UserService>();

  @override
  void initState() {
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scrollbar(
            child: FutureBuilder(
                future: _userService.getUsers(),
                builder: (context, AsyncSnapshot<List<User>> snapShot) {
                  if (snapShot.hasData) {
                    return ListView(
                      children: snapShot.data!
                          .map((user) => UserCard(
                              user: user,
                              onDelete: () {
                                _userService
                                    .removeUser(user)
                                    .then((value) => setState(() {
                                          _showSnackBar(
                                              'Deleted user: ' + user.name);
                                        }))
                                    .onError((error, stackTrace) =>
                                        _showSnackBar(error.toString()));
                              },
                              onEdit: () => editUser(user, context)))
                          .toList(),
                    );
                  }
                  return CircularProgressIndicator();
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _nameController.text = "";
          editUser(new User.empty(), context);
        },
      ),
    );
  }

  void editUser(User user, BuildContext context) {
    _nameController.text = user.name;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return UserEditDialog(
              nameController: _nameController,
              editUser: () async {
                user.name = _nameController.text;
                _userService
                    .saveUser(user)
                    .then((value) => setState(() {
                          _showSnackBar('Saved user: ' + user.name);
                        }))
                    .onError(
                        (error, stackTrace) => _showSnackBar(error.toString()));
              });
        });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(duration: const Duration(seconds: 1), content: Text(message)));
  }
}
