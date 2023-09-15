class Exercise {
  int ?id;
  String? name;
  String ?description;

  Exercise({this.id, this.name, this.description});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['description'] = description;
    return map;
  }

  Exercise.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.description = map['description'];
  }
}