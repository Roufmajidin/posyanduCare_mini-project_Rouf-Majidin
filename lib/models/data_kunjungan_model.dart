import 'package:cloud_firestore/cloud_firestore.dart';

class DataKunjunganModel {
  final String doc_id;
  final String nama;
  final String alamat;
  final int berat_badan;
  final int tinggi_badan;
  final String tekanan_darah;
  final String keluhan;

  DataKunjunganModel({
    required this.doc_id,
    required this.nama,
    required this.alamat,
    required this.berat_badan,
    required this.tinggi_badan,
    required this.tekanan_darah,
    required this.keluhan,
  });
  factory DataKunjunganModel.fromJson(DocumentSnapshot doc) {
    return DataKunjunganModel(
        doc_id: doc.id,
        nama: doc.get("nama"),
        alamat: doc.get("alamat"),
        berat_badan: doc.get("berat_badan"),
        tinggi_badan: doc.get("tinggi_badan"),
        tekanan_darah: doc.get("tekanan_darah"),
        keluhan: doc.get("keluhan"));
  }
  // factory DataKunjunganModel.fromJson(Map<String, dynamic> json) {
  //   return DataKunjunganModel(
  //       doc_id: json['user_id'],
  //       nama: json['nama'],
  //       alamat: json['alamat'],
  //       berat_badan: json['berat_badan']?.toDouble(),
  //       tinggi_badan: json['tinggi_badan']?.toDouble(),
  //       keluhan: json['keluhan']);
  // }

  Map<String, dynamic> toMap() {
    return {
      // 'user_id': doc_id,
      'nama': nama,
      'alamat': alamat,
      'berat_badan': berat_badan,
      'tinggi_badan': tinggi_badan,
      'tekanan_darah': tekanan_darah,
      'keluhan': keluhan,
    };
  }
}
