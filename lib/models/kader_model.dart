import 'package:cloud_firestore/cloud_firestore.dart';

class DataKaderModels {
  final String docId;
  final String nama;
  final String alamat;
  final bool verfiedAt;
  final String jabatan;
  final String image;

  DataKaderModels({
    required this.docId,
    required this.nama,
    required this.alamat,
    required this.verfiedAt,
    required this.jabatan,
    required this.image,
  });
  factory DataKaderModels.fromJson(DocumentSnapshot doc) {
    return DataKaderModels(
      docId: doc.id,
      nama: doc.get("nama"),
      alamat: doc.get("alamat"),
      verfiedAt: doc.get("verified_status"),
      jabatan: doc.get("jabatan"),
      image: doc.get("image"),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'user_id': doc_id,
      'nama': nama,
      'alamat': alamat,
      'verified_status': verfiedAt,
      'jabatan': jabatan,
      'image': image,
    };
  }
}
