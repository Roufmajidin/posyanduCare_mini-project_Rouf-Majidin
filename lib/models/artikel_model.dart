import 'package:cloud_firestore/cloud_firestore.dart';

class ArtikelModel {
  final String docId;
  final String judulArtikel;
  final String tanggalPublish;
  final String isiArtikel;
  final String image;

  ArtikelModel({
    required this.docId,
    required this.judulArtikel,
    required this.tanggalPublish,
    required this.isiArtikel,
    required this.image,
  });
  factory ArtikelModel.fromJson(DocumentSnapshot doc) {
    return ArtikelModel(
      docId: doc.id,
      judulArtikel: doc.get("judul_artikel"),
      tanggalPublish: doc.get("tanggal_publish"),
      isiArtikel: doc.get("isi_artikel"),
      image: doc.get("image"),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'user_id': doc_id,
      'judul_artikel': judulArtikel,
      'tanggal_publish': tanggalPublish,
      'isi_artikel': isiArtikel,
      'image': image,
    };
  }
}
