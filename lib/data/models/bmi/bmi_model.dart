class BmiModel {
  String id;
  double weight;
  double height;
  int age;
  DateTime createdDate;
  String bmiStatus;
  double bmiValue;
  BmiModel({
    required this.id,
    required this.weight,
    required this.height,
    required this.age,
    required this.createdDate,
    required this.bmiStatus,
    required this.bmiValue,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      'weight': weight,
      'height': height,
      'age': age,
      'created_date': createdDate.millisecondsSinceEpoch,
      'bmi_status': bmiStatus,
      'bmi_value': bmiValue,
    };
  }

  factory BmiModel.fromMap(Map<String, dynamic> map) {
    return BmiModel(
      id: map['id'] as String,
      weight: double.parse(map['weight'].toString()),
      height: double.parse(map['height'].toString()),
      age: int.parse(map['age'].toString()),
      createdDate:
          DateTime.fromMillisecondsSinceEpoch(map['created_date'] as int),
      bmiStatus: map['bmi_status'] as String,
      bmiValue: map['bmi_value'] as double,
    );
  }

  @override
  String toString() {
    return 'BmiModel(id: $id, weight: $weight, height: $height, age: $age, createdDate: $createdDate, bmiStatus: $bmiStatus, bmiValue: $bmiValue)';
  }
}
