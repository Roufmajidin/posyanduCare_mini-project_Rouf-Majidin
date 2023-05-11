import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:posyandu_care_apps/models/puskesmas_models.dart';
import 'package:posyandu_care_apps/models/upt_models.dart';
import 'package:posyandu_care_apps/models/user_models.dart';
import 'package:posyandu_care_apps/view_model/login_provider.dart';

enum RequestState { empty, loading, loaded, error }

class UptProvider extends ChangeNotifier {
  // List<DataUptModels> dataKunjunganfetched = [];
  DataUptModels? _item;
  DataUptModels? get item => _item;

  UserModel? _idPosyanduByLogin;
  UserModel? get i => _idPosyanduByLogin;

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
    _requestState = RequestState.loaded;
    _item = DataUptModels.fromJson(documentSnapshot);
    print(_item);
    print("OK");

    notifyListeners();
  }

  Future fetchDataPosyanduById() async {
    String id = item!.docId;
    print("object");
    _requestState = RequestState.loading;
    notifyListeners();

    final DocumentSnapshot documentSnapshot =
        await firestore.collection('posyandu').doc(i!.posyanduId).get();
    // print('ini id Posyandu yang login :${i}');
    _requestState = RequestState.loaded;
    _itemPuskemas = DataPuskesmas.fromJson(documentSnapshot);
    notifyListeners();
  }
}
