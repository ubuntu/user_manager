import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserEditDialog extends StatefulWidget {
  final TextEditingController nameController;
  final AsyncCallback editUser;

  UserEditDialog({required this.nameController, required this.editUser});

  @override
  _UserEditDialogState createState() => _UserEditDialogState();
}

class _UserEditDialogState extends State<UserEditDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 150,
        width: 200,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  autofocus: true,
                  controller: widget.nameController,
                  decoration: InputDecoration(hintText: 'User name'),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async =>
                          Navigator.of(context).pop(widget.editUser()),
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("Cancel"),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
