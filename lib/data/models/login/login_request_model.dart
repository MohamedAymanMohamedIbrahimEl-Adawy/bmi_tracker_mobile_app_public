import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginRequestModel {
  String? name;
  String id;
  DateTime createdDate;
  LoginRequestModel({
    this.name,
    required this.id,
    required this.createdDate,
  });

  @override
  String toString() =>
      'LoginRequestModel(name: $name, id: $id, createdDate: $createdDate)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'created_date': createdDate.millisecondsSinceEpoch,
    };
  }

  factory LoginRequestModel.fromMap(Map<String, dynamic> map) {
    return LoginRequestModel(
      name: map['name'] != null ? map['name'] as String : null,
      id: map['id'] as String,
      createdDate:
          DateTime.fromMillisecondsSinceEpoch(map['created_date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequestModel.fromJson(String source) =>
      LoginRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
