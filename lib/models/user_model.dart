class User {
  final String id;
  final String name;
  final String surname;
  final String email;
  final String gender;
  final String localId;
  final String bornData;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.gender,
    required this.localId,
    required this.bornData,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      surname: json['sur-name'],
      email: json['email'],
      gender: json['gender'],
      localId: json['local-id'],
      bornData: json['born-data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sur-name': surname,
      'email': email,
      'gender': gender,
      'local-id': localId,
      'born-data': bornData,
    };
  }
}
