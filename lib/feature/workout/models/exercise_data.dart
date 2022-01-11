import 'dart:convert';

class ExerciseData {
  String? id;
  String? title;
  int? sets;
  int? reps;
  double? weight;
  String? image;
  String? description;

  ExerciseData({
    required this.id,
    required this.title,
    required this.sets,
    required this.reps,
    required this.weight,
    required this.image,
    required this.description,
  });

  ExerciseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    sets = json['sets'];
    reps = json['reps'];
    weight = json['weight'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['sets'] = this.sets;
    data['reps'] = this.reps;
    data['weight'] = this.weight;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }

  String toJsonString() {
    final str = json.encode(this.toJson());
    return str;
  }
}
