import 'package:cloud_firestore/cloud_firestore.dart';

class RekomendasiObatModels {
  final String docId;
  final String dataObat;
  final bool isVerified;
  final String penanggungJawab;
  final String dokterTugas;
  final Timestamp tanggalKunjungan;
  final String tanggalVerifikasi;
  final Timestamp updatedAt;

  RekomendasiObatModels({
    required this.docId,
    required this.dataObat,
    required this.dokterTugas,
    required this.isVerified,
    required this.penanggungJawab,
    required this.tanggalKunjungan,
    required this.tanggalVerifikasi,
    required this.updatedAt,
  });
  factory RekomendasiObatModels.fromJson(DocumentSnapshot doc) {
    return RekomendasiObatModels(
      docId: doc.id,
      dataObat: doc.get("data_obat"),
      dokterTugas: doc.get("dokter_tugas"),
      isVerified: doc.get("is_verified"),
      penanggungJawab: doc.get("penanggung_jawab"),
      tanggalKunjungan: doc.get("tanggal_kunjungan"),
      tanggalVerifikasi: doc.get("tanggal_verifikasi"),
      updatedAt: doc.get("updated_at"),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data_obat': dataObat,
      'is_verified': isVerified,
      'dokter_tugas': dokterTugas,
      'penanggung_jawab': penanggungJawab,
      'tanggal_kunjungan': tanggalKunjungan,
      'tanggal_verifikasi': tanggalVerifikasi,
      'updated_at': updatedAt,
    };
  }
}
