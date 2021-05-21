import 'package:flutter/material.dart';
import 'package:user_manager/model/user.dart';

class UserCard extends StatefulWidget {
  final User user;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  UserCard({required this.user, required this.onDelete, required this.onEdit});

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text(widget.user.name),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('Edit'),
                onPressed: () => widget.onEdit(),
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('Remove'),
                onPressed: () => widget.onDelete(),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
