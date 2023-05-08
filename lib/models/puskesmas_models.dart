import 'package:cloud_firestore/cloud_firestore.dart';

class DataPuskesmas {
  final String docId;
  final String uptId;
  final String nama;
  final String desa;
  final String dokterPembina;

  DataPuskesmas({
    required this.docId,
    required this.uptId,
    required this.nama,
    required this.desa,
    required this.dokterPembina,
  });
  factory DataPuskesmas.fromJson(DocumentSnapshot doc) {
    return DataPuskesmas(
      docId: doc.id,
      uptId: doc.get("upt_id"),
      nama: doc.get("nama"),
      desa: doc.get("desa"),
      dokterPembina: doc.get("dokter_pembina"),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'user_id': doc_id,
      'upt_id': uptId,
      'nama': nama,
      'desa': desa,
      'dokter_pembina': dokterPembina,
    };
  }
}
