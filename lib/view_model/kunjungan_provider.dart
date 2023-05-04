import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:posyandu_care_apps/models/data_kunjungan_model.dart';

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
      // print(_dataKunjungan.map((e) => print()));
      // for (var element in dataKunjunganfetched) {
      //   print(element.nama);
      // }
    });
    notifyListeners();

    // _newKunjungan = usersKunjungan;
    // for (var element in newKunjungan) {
    //   print(element.nama);
    // }
    // print(a);
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future fetchDataKunjunganById(String id) async {
    print("ok}");
    final DocumentSnapshot documentSnap =
        await firestore.collection('data_kunjungan').doc(id).get();

    _item = DataKunjunganModel.fromJson(documentSnap);
    notifyListeners();
    // }
    print(_item!.alamat);
  }

  Future<void> addDataKunjungan(DataKunjunganModel dataKunjungan) async {
    // _requestState = RequestState.loading;
    // notifyListeners();
    // 1
    await FirebaseFirestore.instance
        .collection("data_kunjungan")
        .doc()
        .set(dataKunjungan.toMap());
    // 2
    // await FirebaseFirestore.instance
    //     .collection("data_kunjungan")
    //     .add(dataKunjungan.toJson());

    notifyListeners();
    // }
  }
}
