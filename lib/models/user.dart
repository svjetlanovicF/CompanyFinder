import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  String? email;
  String? password;
  String? username;
  String? fullname;
  String? phone;
  String? birth;
  String? imageUrl;

  User({this.email, this.password, this.fullname, this.username, this.phone, this.birth, this.imageUrl});

  static User fromJson(Map<String, dynamic> json)  => User(
    email: json['email'],
    fullname: json['fullname'],
    username: json['username'],
    // phone: json['phone'],
    // birth: (json['birthday'] as Timestamp).toDate()
  );

  @override
  String toString() {
    return '$imageUrl $fullname $phone $birth';
  }
}