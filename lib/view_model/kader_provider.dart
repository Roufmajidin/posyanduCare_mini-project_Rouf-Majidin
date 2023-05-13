import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:posyandu_care_apps/models/kader_model.dart';

import '../models/data_kunjungan_model.dart';

enum RequestState { empty, loading, loaded, error }

class KaderProvider extends ChangeNotifier {
  List<DataKaderModels> kaderFetched = [];
  // List<DataKunjunganModel> dataKunjunganfetchedById = [];
  DataKaderModels? _itemKader;
  DataKaderModels? get item => _itemKader;

  RequestState _requestState = RequestState.empty;
  RequestState get requestState => _requestState;
  // untuk generate doId
  // String id = DateTime.now().millisecondsSinceEpoch.toString();
  //
  String _message = '';
  String posisiKader = '';
  String get message => _message;
  String gambarKader = '';
  String gambarKaderUpdate = "";
  Future fetchDataKader() async {
    _requestState = RequestState.loading;
    notifyListeners();
    final snapshot = await FirebaseFirestore.instance.collection('data_kader');

    snapshot.snapshots().listen((snapshot) {
      kaderFetched = snapshot.docs
          .map((doc) => DataKaderModels(
              docId: doc.id,
              nama: doc.get('nama'),
              alamat: doc.get('alamat'),
              verfiedAt: doc.get('verified_status'),
              jabatan: doc.get('jabatan'),
              image: doc.get('image'),
              pesan: doc.get('pesan')))
          .toList();
      _requestState = RequestState.loaded;

      notifyListeners();
    });
    notifyListeners();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future fetchKaderById(String id) async {
    final DocumentSnapshot documentSnap =
        await firestore.collection('data_kader').doc(id).get();
    // get data collection rekomendasi_obat :) tapi data obat belum terverifikasi / masih null

    _itemKader = DataKaderModels.fromJson(documentSnap);
    print("snap");

    _requestState = RequestState.loaded;

    notifyListeners();
  }

  Future<void> addDataKader(DataKaderModels dataKunjungan) async {
    // _requestState = RequestState.loading;
    // notifyListeners();

    // TODOD : 1 save data ke collection add data kader ke collection data_kader
    await FirebaseFirestore.instance
        .collection("data_kader")
        .doc(dataKunjungan.docId)
        .set(dataKunjungan.toMap());
    print("ID : ${dataKunjungan.docId}");

    // await FirebaseFirestore.instance
    //     .collection("data_kunjungan")
    //     .add(dataKunjungan.toJson());

    notifyListeners();
    // }
  }

  void pickImage() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 75);

    Reference ref = FirebaseStorage.instance
        .ref()
        .child('gambarKader/${DateTime.now()}.jpg');
    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      gambarKader = value;
      print("terpilih gambar ${value}");

      notifyListeners();
    });
    // notifyListeners();
  }

  void updatepickImage() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 75);

    Reference ref = FirebaseStorage.instance
        .ref()
        .child('gambarKader/${DateTime.now()}.jpg');
    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      gambarKaderUpdate = value;
      print("terpilih gambar ${value}");

      notifyListeners();
    });
  }

  Future<void> updateDataKader(DataKaderModels dataKader) async {
    // TODOD : 1 save data ke collection data_kunjungan
    await FirebaseFirestore.instance
        .collection("data_kader")
        .doc(dataKader.docId)
        .update(dataKader.toMap());
    print("ini id nya : ${dataKader.docId} Sukses Update Data Kader");

    notifyListeners();
  }

  Future<void> verifikasiKader(docId, status, String pesan) async {
    // TODOD : 1 save data ke collection data_kunjungan
    await FirebaseFirestore.instance.collection("data_kader").doc(docId).set({
      'verified_status': true,
      'pesan': pesan,
    }, SetOptions(merge: true));

    notifyListeners();
  }

  Future<void> deleteDataKader(docId) async {
    // TODOD : 1 save data ke collection data_kunjungan
    await FirebaseFirestore.instance
        .collection("data_kader")
        .doc(docId)
        .delete();
    print("ini id nya : ${docId} Sukses Delete Data Kader");

    notifyListeners();
  }
}
