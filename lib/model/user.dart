class User {
  int? id;
  String name;

  User({required this.id, required this.name});

  User.empty() : this(id: null, name: "");

  factory User.fromJson(Map<String, dynamic> json) =>
      User(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
