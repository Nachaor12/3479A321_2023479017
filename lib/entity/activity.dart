

class Activity{
  int id;
  String name;
  String date;

  Activity({required this.id, required this.date, required this.name});

  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'date': date};
  }

  @override
  String toString() {
    return 'Activity\n{id: $id, \nname: $name, \ndate: $date}';
  }

  factory Activity.fromMap(Map<String, dynamic> map){
    return Activity(
      id: map['id'],
      name: map['name'],
      date: map['date'],
    );
  }
}
