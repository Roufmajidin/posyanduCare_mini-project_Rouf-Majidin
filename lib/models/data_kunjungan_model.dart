import 'package:cloud_firestore/cloud_firestore.dart';

class DataKunjunganModel {
  final String nama;
  final String alamat;
  final int berat_badan;
  final int tinggi_badan;
  final String keluhan;

  DataKunjunganModel({
    required this.nama,
    required this.alamat,
    required this.berat_badan,
    required this.tinggi_badan,
    required this.keluhan,
  });
  factory DataKunjunganModel.fromJson(DocumentSnapshot doc) {
    return DataKunjunganModel(
        nama: doc.get("nama"),
        alamat: doc.get("alamat"),
        berat_badan: doc.get("berat_badan")?.toDouble(),
        tinggi_badan: doc.get("tinggi_badan")?.toDouble(),
        keluhan: doc.get("keluhan"));
  }
  // factory DataKunjunganModel.fromJson(Map<String, dynamic> json) {
  //   return DataKunjunganModel(
  //       user_id: json['user_id'],
  //       nama: json['nama'],
  //       alamat: json['alamat'],
  //       berat_badan: json['berat_badan']?.toDouble(),
  //       tinggi_badan: json['tinggi_badan']?.toDouble(),
  //       keluhan: json['keluhan']);
  // }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'alamat': alamat,
      'berat_badan': berat_badan,
      'tinggi_badan': tinggi_badan,
      'keluhan': keluhan,
    };
  }
}
