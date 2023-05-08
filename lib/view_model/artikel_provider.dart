import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:posyandu_care_apps/models/artikel_model.dart';
import 'package:posyandu_care_apps/models/puskesmas_models.dart';
import 'package:posyandu_care_apps/models/upt_models.dart';

enum RequestState { empty, loading, loaded, error }

class ArtikelProvider extends ChangeNotifier {
  List<ArtikelModel> dataArtikelFetched = [];
  ArtikelModel? _detailArtikel;
  ArtikelModel? get detailArtikel => _detailArtikel;

  RequestState _requestState = RequestState.empty;
  RequestState get requestState => _requestState;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future fetchDataArtikel() async {
    print("Ok");
    _requestState = RequestState.loading;
    notifyListeners();
    final snapshot = FirebaseFirestore.instance.collection('data_artikel');

    snapshot.snapshots().listen((snapshot) {
      dataArtikelFetched = snapshot.docs
          .map((doc) => ArtikelModel(
              docId: doc.id,
              judulArtikel: doc.get('judul_artikel'),
              tanggalPublish: doc.get('tanggal_publish'),
              isiArtikel: doc.get('isi_artikel'),
              image: doc.get('image')))
          .toList();
      _requestState = RequestState.loaded;

      notifyListeners();
      for (var element in dataArtikelFetched) {
        print(element.image);
      }
      print(dataArtikelFetched);
    });
    notifyListeners();
  }

  Future fetchDataArtikelById(String id) async {
    print("object");
    _requestState = RequestState.loading;
    notifyListeners();
    final DocumentSnapshot documentSnapshot =
        await firestore.collection('data_artikel').doc(id).get();
    _requestState = RequestState.loaded;
    _detailArtikel = ArtikelModel.fromJson(documentSnapshot);

    notifyListeners();
  }
}
