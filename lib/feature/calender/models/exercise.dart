class Exercise {
  int id;
  int category;
  String name;

  Exercise.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        category = json['category'],
        name = json['name'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['name'] = this.name;
    return data;
  }
}
