import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:posyandu_care_apps/models/data_kunjungan_model.dart';
import 'package:posyandu_care_apps/models/rekomendasi_obat_model.dart';
import 'package:posyandu_care_apps/view_model/kunjungan_provider.dart';

import '../../themes/style.dart';

class WidgetDialog extends StatelessWidget {
  WidgetDialog({
    required this.formKey,
    // required this.widget,
    super.key,
    required this.status,
    required this.provDetail,
  });
  String status;
  final KunjunganProvider provDetail;

  final GlobalKey<FormState> formKey;
  // final KunjunganDetail widget;
  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController bbController = TextEditingController();
  final TextEditingController tinggiController = TextEditingController();
  final TextEditingController darahController = TextEditingController();
  final TextEditingController keluhanController = TextEditingController();
  final TextEditingController rekamObatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var nama = provDetail.item!.nama;
    var alamat = provDetail.item!.alamat;
    var tinggi = provDetail.item!.tinggi_badan;
    var berat = provDetail.item!.berat_badan;
    var tekanan_darah = provDetail.item!.tekanan_darah;
    var keluhan = provDetail.item!.keluhan;
    // log(status);
    return GestureDetector(
      child: Text(
        status,
        style: TextStyle(color: AppTheme.primaryColor),
      ),
      onTap: () {
        status == "Update Data"
            ? showDialog(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    icon: Builder(builder: (context) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.close),
                        ),
                      );
                    }),
                    insetPadding: EdgeInsets.all(8),
                    content: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.height,
                        // form widget
                        child: Column(children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(12),
                            height: 2,
                            width: 100,
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Add Data Kader Posyandu',
                            style: TextStyle(
                                color: Colors.grey[600], // Set the text color.
                                fontSize: 16 // Set the text size.
                                ),
                          ),
                          const SizedBox(height: 10),
                          Form(
                            key: formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: TextFormField(
                                    autofocus: true,
                                    controller: namaController..text = nama,
                                    onChanged: (value) {
                                      nama = value;
                                    },
                                    validator: (value) {},
                                    obscureText: false,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Nama Warga',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 40,
                                  child: TextFormField(
                                    controller: alamatController..text = alamat,
                                    onChanged: (value) {
                                      alamat = value;
                                    },
                                    validator: (value) {},
                                    obscureText: false,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Alamat',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 40,
                                  child: TextFormField(
                                    controller: bbController
                                      ..text = berat.toString(),
                                    onChanged: (value) {
                                      berat = int.parse(value);
                                    },
                                    validator: (value) {},
                                    obscureText: false,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Berat Badan (Kg)',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 40,
                                  child: TextFormField(
                                    controller: tinggiController
                                      ..text = tinggi.toString(),
                                    onChanged: (value) {
                                      tinggi = int.parse(value);
                                    },
                                    validator: (value) {},
                                    obscureText: false,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Tinggi Badan (Cm)',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 40,
                                  child: TextFormField(
                                    controller: darahController
                                      ..text = tekanan_darah,
                                    onChanged: (value) {
                                      tekanan_darah = value;
                                    },
                                    validator: (value) {},
                                    obscureText: false,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Tekanan Darah (Bpm)',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 80,
                                  child: TextFormField(
                                    controller: keluhanController
                                      ..text = keluhan,
                                    onChanged: (value) {
                                      keluhan = value;
                                    },
                                    validator: (value) {},
                                    obscureText: false,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Keluhan',
                                    ),
                                    maxLines: 4,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: AppTheme.primaryColor),
                                  onPressed: () {
                                    String id = DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString();
                                    final nama = namaController;

                                    DataKunjunganModel updateData =
                                        DataKunjunganModel(
                                            doc_id: provDetail.item!.doc_id,
                                            nama: nama.text,
                                            alamat: alamat,
                                            berat_badan: berat,
                                            tinggi_badan: tinggi,
                                            tekanan_darah: tekanan_darah,
                                            keluhan: keluhan);

                                    provDetail
                                        .updateDataKunjungan(updateData)
                                        .whenComplete(() {
                                      namaController.clear();
                                      alamatController.clear();
                                      bbController.clear();
                                      tinggiController.clear();
                                      darahController.clear();
                                      keluhanController.clear();
                                      // provDetail.fetchDataKunjunganById(whereDocId);

                                      Navigator.pop(context);
                                      final snackBar = SnackBar(
                                        content: Text('Sukses Update data'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);

                                      // setState(() {});
                                      return snackBar;
                                    });
                                  },
                                  child: Center(
                                    child: Text(
                                      "Update",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
                  );
                },
              )
            : showDialog(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    icon: Builder(builder: (context) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.close),
                        ),
                      );
                    }),
                    insetPadding: EdgeInsets.all(8),
                    content: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.height,
                        // form widget
                        child: Column(children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(12),
                            height: 2,
                            width: 100,
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            status,
                            style: TextStyle(
                                color: Colors.grey[600], // Set the text color.
                                fontSize: 16 // Set the text size.
                                ),
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 80,
                            child: TextFormField(
                              readOnly: true,
                              controller: keluhanController..text = keluhan,
                              onChanged: (value) {
                                keluhan = value;
                              },
                              validator: (value) {},
                              obscureText: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Keluhan',
                              ),
                              maxLines: 2,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 80,
                            child: TextFormField(
                              // readOnly: true,
                              controller: rekamObatController,
                              onChanged: (value) {
                                keluhan = value;
                              },
                              validator: (value) {},
                              obscureText: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Rekam Obat',
                              ),
                              maxLines: 4,
                            ),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppTheme.primaryColor),
                              onPressed: () {
                                String id = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString();
                                final nama = namaController;
                                print(provDetail.item!.doc_id);
                                final tanggalVerified = DateTime.now();
                                RekomendasiObatModels updateData =
                                    RekomendasiObatModels(
                                        docId:
                                            provDetail.itemRekomendasi!.docId,
                                        dataObat: rekamObatController.text,
                                        dokterTugas: provDetail
                                            .itemRekomendasi!.dokterTugas,
                                        isVerified: true,
                                        penanggungJawab: provDetail
                                            .itemRekomendasi!.penanggungJawab,
                                        tanggalKunjungan: Timestamp.now(),
                                        tanggalVerifikasi:
                                            tanggalVerified.timeZoneName,
                                        updatedAt: Timestamp.now());
                                provDetail
                                    .updateDataRekamObat(updateData)
                                    .whenComplete(() {
                                  print("update");
                                  print(provDetail.itemRekomendasi?.docId);
                                  namaController.clear();
                                  alamatController.clear();
                                  bbController.clear();
                                  tinggiController.clear();
                                  darahController.clear();
                                  keluhanController.clear();
                                  provDetail.fetchDataKunjunganById(
                                      provDetail.item!.doc_id);

                                  Navigator.pop(context);
                                  final snackBar = SnackBar(
                                    content: Text('Sukses Verifikasi data'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);

                                  // setState(() {});
                                  return snackBar;
                                });
                              },
                              child: const Center(
                                child: Text(
                                  "Verifikasi",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ))
                        ]),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
