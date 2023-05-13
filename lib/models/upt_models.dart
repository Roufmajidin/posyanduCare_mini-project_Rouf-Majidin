import 'package:cloud_firestore/cloud_firestore.dart';

class DataUptModels {
  final String? docId;
  final String? namaUpt;
  final String? alamat;
  final String? kecamatan;
  final String? kabupaten;
  final int? kodePos;
  final String? noBangunan;

  DataUptModels({
    required this.docId,
    required this.namaUpt,
    required this.alamat,
    required this.kecamatan,
    required this.kabupaten,
    required this.kodePos,
    required this.noBangunan,
  });
  factory DataUptModels.fromJson(DocumentSnapshot doc) {
    return DataUptModels(
      docId: doc.id,
      namaUpt: doc.get("nama_upt"),
      alamat: doc.get("alamat"),
      kecamatan: doc.get("kecamatan"),
      kabupaten: doc.get("kabupaten"),
      kodePos: doc.get("kode_pos"),
      noBangunan: doc.get("no_bangunan"),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'user_id': doc_id,
      'nama_upt': namaUpt,
      'alamat': alamat,
      'kecamatan': kecamatan,
      'kabupaten': kabupaten,
      'kode_pos': kodePos,
      'no_bangunan': noBangunan,
    };
  }
}
