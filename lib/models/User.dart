class User {
  final String name;
  final String surname;

  User({this.name, this.surname});
  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        surname = json['surname'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['surname'] = this.surname;
    return data;
  }

}
