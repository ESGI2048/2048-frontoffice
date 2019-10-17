
class Component {

  int id, value;
  String name, type, file_path;

  Component(this.value, this.file_path);

  // named constructor
  Component.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        value = json['value'],
        name = json['name'],
        file_path = json['file_path'],
        type = json['type'];

  // method
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "value": value,
      "name": name,
      "file_path": file_path,
      "type": type,
    };
  }

  /*
  String toJsonString() {
    return '{"login": "$login", "password": "$password"}';
  }

   */
}