import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:posyandu_care_apps/models/data_kunjungan_model.dart';

import '../models/data_kunjungan_model.dart';

enum RequestState { empty, loading, loaded, error }

class KunjunganProvider extends ChangeNotifier {
  List<DataKunjunganModel> dataKunjunganfetched = [];
  // late final DataKunjunganModel dataKunjunganM;
  List<DataKunjunganModel> _newKunjungan = [];
  List<DataKunjunganModel> get newKunjungan => dataKunjunganfetched;

  RequestState _requestState = RequestState.empty;
  RequestState get requestState => _requestState;

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
              nama: doc.get("nama"),
              alamat: doc.get("alamat"),
              berat_badan: doc.get("berat_badan"),
              tinggi_badan: doc.get("tinggi_badan"),
              keluhan: doc.get("keluhan")))
          .toList();
      _requestState = RequestState.loaded;
      notifyListeners();
      // print(_dataKunjungan.map((e) => print()));
      // for (var element in dataKunjunganfetched) {
      //   print(element.nama);
      // }
    });

    // _newKunjungan = usersKunjungan;
    // for (var element in newKunjungan) {
    //   print(element.nama);
    // }
    // print(a);
  }

  Future fetchDataKunjunganById(String name) async {
    // _requestState = RequestState.loading;
    // notifyListeners();
    final snapshot = await FirebaseFirestore.instance
        .collection('data_kunjungan')
        .where("user_id", isEqualTo: name);

    snapshot.snapshots().listen((snapshot) {
      dataKunjunganfetched = snapshot.docs
          .map((doc) => DataKunjunganModel(
              nama: doc.get("nama"),
              alamat: doc.get("alamat"),
              berat_badan: doc.get("berat_badan"),
              tinggi_badan: doc.get("tinggi_badan"),
              keluhan: doc.get("keluhan")))
          .toList();
      // _requestState = RequestState.loaded;
      notifyListeners();
      print(dataKunjunganfetched);
      // print(_dataKunjungan.map((e) => print()));
      // for (var element in dataKunjunganfetched) {
      //   print(element.nama);
      // }
    });

    // _newKunjungan = usersKunjungan;
    // for (var element in newKunjungan) {
    //   print(element.nama);
    // }
    // print(a);
    notifyListeners();
  }

  Future<void> addDataKunjungan(DataKunjunganModel dataKunjungan) async {
    // _requestState = RequestState.loading;
    // notifyListeners();
    // 1
    await FirebaseFirestore.instance
        .collection("data_kunjungan")
        .doc()
        .set(dataKunjungan.toJson());
    // 2
    // await FirebaseFirestore.instance
    //     .collection("data_kunjungan")
    //     .add(dataKunjungan.toJson());

    notifyListeners();
  }
}
