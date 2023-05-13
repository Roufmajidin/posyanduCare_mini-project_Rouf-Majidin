import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:posyandu_care_apps/models/puskesmas_models.dart';
import 'package:posyandu_care_apps/models/upt_models.dart';

enum RequestState { empty, loading, loaded, error }

class UptProvider extends ChangeNotifier {
  // List<DataUptModels> dataKunjunganfetched = [];
  DataUptModels? _item;
  DataUptModels? get item => _item;

  // UserModel? _idPosyanduByLogin;
  // UserModel? get i => _idPosyanduByLogin;

// data Posyandu by id dari item.id puskesmas
  DataPuskesmas? _itemPuskemas;
  DataPuskesmas? get itemPuskemas => _itemPuskemas;
  RequestState _requestState = RequestState.empty;
  RequestState get requestState => _requestState;

  String _message = '';
  String get message => _message;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future fetchDataUpt() async {
    log("P");
    _requestState = RequestState.loading;
    notifyListeners();
    final DocumentSnapshot documentSnapshot = await firestore
        .collection('data_upt')
        .doc("iEl06tZbaf0LBPEuEm8w")
        .get();
    _item = DataUptModels.fromJson(documentSnapshot);
    print('alamat${_item!.alamat}');

    print("OK loaded");
    final DocumentSnapshot documentSnapshots = await firestore
        .collection('posyandu')
        .doc("7qtpgjG9XBC0Axrv3wj2")
        .get();

    _itemPuskemas = DataPuskesmas.fromJson(documentSnapshots);

    // print('ini desa${_itemPuskemas!.desa}');
    _requestState = RequestState.loaded;
    print(_itemPuskemas?.desa);
    notifyListeners();
    notifyListeners();
  }

  Future fetchDataPosyanduById(String idPosyandu) async {
    // _requestState = RequestState.loading;
    // notifyListeners();

    print("aigo");
    print(idPosyandu);

    // print('ini id Posyandu yang login :${i!.posyanduId}');
    final DocumentSnapshot documentSnapshot =
        await firestore.collection('posyandu').doc(idPosyandu).get();
    _itemPuskemas = DataPuskesmas.fromJson(documentSnapshot);
    // _requestState = RequestState.loaded;

    notifyListeners();
  }
}
