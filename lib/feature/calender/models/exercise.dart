class Exercise {
  Exercise({
    required this.id,
    required this.category,
    required this.name,
    required this.sets,
    required this.reps,
    required this.weight,
    required this.image,
    required this.description
  });

  int? id;
  int category;
  String name;
  int sets;
  int reps;
  double weight;
  String image;
  String description;

  Exercise.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        category = json['category'],
        name = json['name'],
        sets = json['sets'],
        reps = json['reps'],
        weight = json['weight'],
        image = json['image'],
        description = json['description'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['name'] = this.name;
    data['sets'] = this.sets;
    data['reps'] = this.reps;
    data['weight'] = this.weight;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }
}
