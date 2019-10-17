class User {

  int id, score;
  String first_name, last_name, login, password, email, phone;

  User(this.login, this.password);

  // named constructor
  User.fromJson(Map<String, dynamic> json)
      : login = json['login'],
        password = json['password'];

  // method
  Map<String, dynamic> toJson() {
    return {
      "login": login,
      "password": password,
    };
  }

  String toJsonString() {
    return '{"login": "$login", "password": "$password"}';
  }
}