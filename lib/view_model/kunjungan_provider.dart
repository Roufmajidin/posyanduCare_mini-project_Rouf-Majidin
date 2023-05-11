import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:posyandu_care_apps/models/data_kunjungan_model.dart';
import 'package:posyandu_care_apps/models/rekomendasi_obat_model.dart';

import '../models/data_kunjungan_model.dart';

enum RequestState { empty, loading, loaded, error }

class KunjunganProvider extends ChangeNotifier {
  List<DataKunjunganModel> dataKunjunganfetched = [];
  // List<DataKunjunganModel> dataKunjunganfetchedById = [];
  DataKunjunganModel? dataById;
  DataKunjunganModel? get product => dataById;
  RequestState _requestState = RequestState.empty;
  RequestState get requestState => _requestState;
  DataKunjunganModel? _item;
  DataKunjunganModel? get item => _item;
  RekomendasiObatModels? _itemRekomendasi;
  RekomendasiObatModels? get itemRekomendasi => _itemRekomendasi;

  String _message = '';
  String get message => _message;

  Future fetchDataKunjungan() async {
    _requestState = RequestState.loading;
    notifyListeners();
    final snapshot =
        await FirebaseFirestore.instance.collection('data_kunjungan');

    snapshot.snapshots().listen((snapshot) {
      dataKunjunganfetched = snapshot.docs
          .map((doc) => DataKunjunganModel(
              doc_id: doc.id,
              nama: doc.get("nama"),
              alamat: doc.get("alamat"),
              berat_badan: doc.get("berat_badan"),
              tinggi_badan: doc.get("tinggi_badan"),
              tekanan_darah: doc.get("tekanan_darah"),
              keluhan: doc.get("keluhan")))
          .toList();
      _requestState = RequestState.loaded;

      notifyListeners();
    });
    notifyListeners();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future fetchDataKunjunganById(String id) async {
    final DocumentSnapshot documentSnap =
        await firestore.collection('data_kunjungan').doc(id).get();
    // get data collection rekomendasi_obat :) tapi data obat belum terverifikasi / masih null

    _item = DataKunjunganModel.fromJson(documentSnap);
    print("snp");
    final DocumentSnapshot documentSnapCollctionObat =
        await firestore.collection('rekomendasi_obat').doc(id).get();
    _requestState = RequestState.loaded;
    _itemRekomendasi =
        RekomendasiObatModels.fromJson(documentSnapCollctionObat);
    print("bad");
    notifyListeners();
  }

  Future<void> addDataKunjungan(DataKunjunganModel dataKunjungan) async {
    // _requestState = RequestState.loading;
    // notifyListeners();

    // TODOD : 1 save data ke collection data_kunjungan
    await FirebaseFirestore.instance
        .collection("data_kunjungan")
        .doc(dataKunjungan.doc_id)
        .set(dataKunjungan.toMap());
    print("ini id nya : ${dataKunjungan.doc_id}");
    const String namaPuskesmas = "UPT Dukupuntang";
    final tanggal = DateTime.now();
    const String dokterTugas = "Shinta, Amd. Kep";
    await FirebaseFirestore.instance
        .collection('rekomendasi_obat')
        .doc(dataKunjungan.doc_id)
        .set({
      'data_obat': null.toString(),
      'dokter_tugas': dokterTugas,
      'is_verified': false,
      'penanggung_jawab': namaPuskesmas,
      'tanggal_kunjungan': tanggal,
      'tanggal_verifikasi': null.toString(),
      'updated_at': tanggal
    });

    // TODO malam ini : bikin modeols baru (rekomendasi_obat);  DONE

    // await FirebaseFirestore.instance
    //     .collection("data_kunjungan")
    //     .add(dataKunjungan.toJson());

    notifyListeners();
    // }
  }

// TODO inProgress => update data kunjungan
  Future<void> updateDataKunjungan(DataKunjunganModel dataKunjungan) async {
    // _requestState = RequestState.loading;
    // notifyListeners();

    // TODOD : 1 save data ke collection data_kunjungan
    await FirebaseFirestore.instance
        .collection("data_kunjungan")
        .doc(dataKunjungan.doc_id)
        .set(dataKunjungan.toMap());
    print("ini id nya : ${dataKunjungan.doc_id} Sukses Update Data Kunjungan");

    notifyListeners();
  }

  Future<void> hapusKunjungan(docId) async {
    // _requestState = RequestState.loading;
    // notifyListeners();

    // TODOD : 1 save data ke collection data_kunjungan
    await FirebaseFirestore.instance
        .collection("data_kunjungan")
        .doc(docId)
        .delete()
        .whenComplete(() async {
      await FirebaseFirestore.instance
          .collection("rekomendasi_obat")
          .doc(docId)
          .delete();
    });

    notifyListeners();
  }

  Future<void> updateDataRekamObat(RekomendasiObatModels dataVerified) async {
    // TODO : 1 update data ke collection update data rekam obar ke collection rekam obat
    await FirebaseFirestore.instance
        .collection("rekomendasi_obat")
        .doc(dataVerified.docId)
        .set(dataVerified.toMap());
    print("ini id nya : ${dataVerified.docId} Sukses Update Data Kunjungan");

    notifyListeners();
  }
}
