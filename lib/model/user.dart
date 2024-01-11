class User {
  int? id;
  String? name;
  String? email;
  int? age;
  String? account_type;
  String? token;

  User({
    this.id,
    this.name,
    this.email,
    this.age,
    this.account_type,
    this.token
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
        id: json['user']['id'],
        name: json['user']['name'],
        email: json['user']['email'],
        age: json['user']['age'],
        account_type: json['user']['account_type'],
        token: json['token']
    );
  }
}