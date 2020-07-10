class User {
  final String id;
  final String name;
  final String email;
  final String role;

  User({this.id, this.name, this.email, this.role});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        name = data['fullName'],
        email = data['email'],
        role = data['role'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': name,
      'email': email,
      'role': role,
    };
  }
}