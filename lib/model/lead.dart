import 'package:floor/floor.dart';

@Entity(tableName: 'leads')
class Lead {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final String email;
  final String phone;
  final String source;
  final String status;

  Lead({this.id, required this.name, required this.email, required this.phone, required this.source, required this.status});

  Lead copyWith({int? id, String? name, String? email, String? phone, String? source, String? status}) {
    return Lead(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      source: source ?? this.source,
      status: status ?? this.status,
    );
  }
}