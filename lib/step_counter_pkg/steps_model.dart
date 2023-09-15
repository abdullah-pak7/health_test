class Steps {
  int ?id;
  String? steps;

  Steps({this.id, this.steps,});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['steps'] = steps;
    return map;
  }

  Steps.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.steps = map['steps'];
  }
}