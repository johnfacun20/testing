class Student {
  int? id;
  String? name;

  Student({
    this.id,
    this.name,
  });

  factory Student.fromJson(Map<String, dynamic> json){
    return Student(
        id: json['student']['id'],
        name: json['student']['name'],
    );
  }
}