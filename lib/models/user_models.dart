import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String docId;
  final String email;
  final String username;
  final String role;
  final String posyanduId;

  UserModel({
    required this.docId,
    required this.email,
    required this.username,
    required this.role,
    required this.posyanduId,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "docId": docId,
        "role": role,
        "username": username,
        "posyandu_id": posyanduId,
      };

  static UserModel fromSnap(DocumentSnapshot doc) {
    return UserModel(
      email: doc.get('email'),
      docId: doc.id,
      role: doc.get('role'),
      username: doc.get('username'),
      posyanduId: doc.get('posyandu_id'),
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      docId: json['id'] as String,
      username: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      posyanduId: json['posyandu_id'] as String,
    );
  }
}
