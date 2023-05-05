import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  String _message = '';
  String get message => _message;

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
              image: doc.get('image')))
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
}
