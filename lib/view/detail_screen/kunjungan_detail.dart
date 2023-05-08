import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:posyandu_care_apps/view_model/kunjungan_provider.dart';
import 'package:provider/provider.dart';

import '../../models/data_kunjungan_model.dart';
import '../../models/list_menu.dart';
import '../../themes/style.dart';

class KunjunganDetail extends StatefulWidget {
  final String whereDocId;

  KunjunganDetail({Key? key, required this.whereDocId}) : super(key: key);

  @override
  State<KunjunganDetail> createState() => _KunjunganDetailState();
}

class _KunjunganDetailState extends State<KunjunganDetail> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<KunjunganProvider>(context, listen: false)
          .fetchDataKunjunganById(widget.whereDocId),
    );
    // get ddetail di collection rekammedis
  }

  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController bbController = TextEditingController();
  final TextEditingController tinggiController = TextEditingController();
  final TextEditingController darahController = TextEditingController();
  final TextEditingController keluhanController = TextEditingController();

  String nama = '';
  String alamat = '';
  late int berat;
  late int tinggi;
  String tekanan_darah = '';
  late String keluhan = '';
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    var formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: customAppBar(mediaquery),
        backgroundColor: AppTheme.primaryColor,
        body: SizedBox(
            height: mediaquery.size.height,
            child: Consumer<KunjunganProvider>(
                builder: (context, provDetail, child) {
              Timestamp tanggalKunjugan =
                  provDetail.itemRekomendasi!.tanggalKunjungan;
              DateTime tanggalKunjunganConvert = tanggalKunjugan.toDate();
              String resultTanggal =
                  DateFormat('dd MMMM yyyy').format(tanggalKunjunganConvert);

              if (provDetail.requestState == RequestState.loading) {
                // provDetail.fetchDataKunjunganById(widget.whereDocId);
                return const Center(child: CircularProgressIndicator());
              } else if (provDetail.requestState == RequestState.loaded) {
                provDetail.fetchDataKunjunganById(widget.whereDocId);
                return Column(
                  children: [
                    // widgetDetail(provDetail, context, formKey, resultTanggal)
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppTheme.bgColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              margin: const EdgeInsets.only(top: 12),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      height: 80,
                                      width: 80,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(IconlyBroken.hide),
                                          Text("no img")
                                        ],
                                      )),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Nama :${provDetail.item!.nama}",
                                        style: PrimaryTextStyle.judulStyle,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Alamat :${provDetail.item!.alamat}",
                                        style: PrimaryTextStyle.subTxt,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      updateDataKunjungan(
                                          provDetail, context, formKey),
                                    ],
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      print("delete data");
                                      provDetail
                                          .hapusKunjungan(widget.whereDocId)
                                          .whenComplete(
                                              () => Navigator.pop(context));
                                      final snackBar = SnackBar(
                                        content: Text('Sukses Delete data'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                    child: SizedBox(
                                      height: 80,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [Icon(IconlyBroken.delete)],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Details Warga",
                                        style: PrimaryTextStyle.judulStyle,
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 120,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Tinggi Badan",
                                                  style:
                                                      PrimaryTextStyle.subTxt,
                                                ),
                                                Text(
                                                  "Berat Badan",
                                                  style:
                                                      PrimaryTextStyle.subTxt,
                                                ),
                                                Text(
                                                  "Tekanan Darah",
                                                  style:
                                                      PrimaryTextStyle.subTxt,
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ": ${provDetail.item!.tinggi_badan.toString()} Cm",
                                                  style:
                                                      PrimaryTextStyle.subTxt,
                                                ),
                                                Text(
                                                  ": ${provDetail.item!.berat_badan.toString()} Kg",
                                                  style:
                                                      PrimaryTextStyle.subTxt,
                                                ),
                                                Text(
                                                  ": ${provDetail.item!.tekanan_darah.toString()} Bpm",
                                                  style:
                                                      PrimaryTextStyle.subTxt,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                      // Image.asset(
                                      //   listBerita[index]["gambar"].toString(),
                                      //   fit: BoxFit.contain,
                                      // )
                                      ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const SizedBox(
                                        height: 80,
                                        child: Center(
                                          child: Text(
                                            "",
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Riwayat Obat",
                                        style: PrimaryTextStyle.judulStyle,
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 130,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Tanggal Kunjungan",
                                                  style:
                                                      PrimaryTextStyle.subTxt,
                                                ),
                                                Text(
                                                  "Keluhan",
                                                  style:
                                                      PrimaryTextStyle.subTxt,
                                                ),
                                                Text(
                                                  "List Obat",
                                                  style:
                                                      PrimaryTextStyle.subTxt,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 140,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ": ${resultTanggal}",
                                                  style:
                                                      PrimaryTextStyle.subTxt,
                                                ),
                                                Text(
                                                  ": ${provDetail.item!.keluhan}",
                                                  style:
                                                      PrimaryTextStyle.subTxt,
                                                ),
                                                provDetail.itemRekomendasi!
                                                            .dataObat ==
                                                        "null"
                                                    ? Text(
                                                        ": Belum terverikasi",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .redAccent,
                                                            fontSize: 14),
                                                      )
                                                    : Text(
                                                        ": ${provDetail.itemRekomendasi!.dataObat}",
                                                        style: PrimaryTextStyle
                                                            .subTxt,
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                      // Image.asset(
                                      //   listBerita[index]["gambar"].toString(),
                                      //   fit: BoxFit.contain,
                                      // )
                                      ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  // Spacer(),
                                  provDetail.itemRekomendasi!.isVerified ==
                                          false
                                      ? Row(
                                          children: const [
                                            Icon(Icons.close,
                                                color: Colors.red),
                                            Text("Unverified",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.red)),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text("verified",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.green)),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Verifikasi",
                                        style: PrimaryTextStyle.judulStyle,
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 160,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Penanggung Jawab",
                                                  style:
                                                      PrimaryTextStyle.subTxt,
                                                ),
                                                Text(
                                                  "Tanggal",
                                                  style:
                                                      PrimaryTextStyle.subTxt,
                                                ),
                                                Text(
                                                  "Dokter tugas",
                                                  style:
                                                      PrimaryTextStyle.subTxt,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 150,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ": ${provDetail.itemRekomendasi!.penanggungJawab}",
                                                  style:
                                                      PrimaryTextStyle.subTxt,
                                                ),
                                                Text(
                                                  ": ${resultTanggal}",
                                                  style:
                                                      PrimaryTextStyle.subTxt,
                                                ),
                                                Text(
                                                  ": ${provDetail.itemRekomendasi!.dokterTugas}",
                                                  style:
                                                      PrimaryTextStyle.subTxt,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                      // Image.asset(
                                      //   listBerita[index]["gambar"].toString(),
                                      //   fit: BoxFit.contain,
                                      // )
                                      ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              if (provDetail.requestState == RequestState.error) {
                return const Center(
                    child: Text(
                        "Gagal Mengambil Data, Periksa Akses Internet Mu"));
              } else {
                return const Text("tidak diketahui");
              }
            })));
  }

  Expanded widgetDetail(KunjunganProvider provDetail, BuildContext context,
      GlobalKey<FormState> formKey, String resultTanggal) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: AppTheme.bgColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(
          children: [
            Container(
              height: 200,
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12)),
                      height: 80,
                      width: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(IconlyBroken.hide),
                          Text("no img")
                        ],
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama :${provDetail.item!.nama}",
                        style: PrimaryTextStyle.judulStyle,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Alamat :${provDetail.item!.alamat}",
                        style: PrimaryTextStyle.subTxt,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      updateDataKunjungan(provDetail, context, formKey),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      print("delete data");
                      provDetail
                          .hapusKunjungan(widget.whereDocId)
                          .whenComplete(() => Navigator.pop(context));
                      final snackBar = SnackBar(
                        content: Text('Sukses Delete data'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: SizedBox(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(IconlyBroken.delete)],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12),
              decoration: const BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Details Warga",
                        style: PrimaryTextStyle.judulStyle,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tinggi Badan",
                                  style: PrimaryTextStyle.subTxt,
                                ),
                                Text(
                                  "Berat Badan",
                                  style: PrimaryTextStyle.subTxt,
                                ),
                                Text(
                                  "Tekanan Darah",
                                  style: PrimaryTextStyle.subTxt,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ": ${provDetail.item!.tinggi_badan.toString()} Cm",
                                  style: PrimaryTextStyle.subTxt,
                                ),
                                Text(
                                  ": ${provDetail.item!.berat_badan.toString()} Kg",
                                  style: PrimaryTextStyle.subTxt,
                                ),
                                Text(
                                  ": ${provDetail.item!.tekanan_darah.toString()} Bpm",
                                  style: PrimaryTextStyle.subTxt,
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                      // Image.asset(
                      //   listBerita[index]["gambar"].toString(),
                      //   fit: BoxFit.contain,
                      // )
                      ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: const SizedBox(
                        height: 80,
                        child: Center(
                          child: Text(
                            "",
                            style: TextStyle(color: Colors.green),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12),
              decoration: const BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Riwayat Obat",
                        style: PrimaryTextStyle.judulStyle,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tanggal Kunjungan",
                                  style: PrimaryTextStyle.subTxt,
                                ),
                                Text(
                                  "Keluhan",
                                  style: PrimaryTextStyle.subTxt,
                                ),
                                Text(
                                  "List Obat",
                                  style: PrimaryTextStyle.subTxt,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 140,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ": ${resultTanggal}",
                                  style: PrimaryTextStyle.subTxt,
                                ),
                                Text(
                                  ": ${provDetail.item!.keluhan}",
                                  style: PrimaryTextStyle.subTxt,
                                ),
                                provDetail.itemRekomendasi!.dataObat == "null"
                                    ? Text(
                                        ": Belum terverified",
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 14),
                                      )
                                    : Text(
                                        ": ${provDetail.itemRekomendasi!.dataObat}",
                                        style: PrimaryTextStyle.subTxt,
                                      ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                      // Image.asset(
                      //   listBerita[index]["gambar"].toString(),
                      //   fit: BoxFit.contain,
                      // )
                      ),

                  // Spacer(),
                  provDetail.itemRekomendasi!.isVerified == false
                      ? Row(
                          children: [
                            Icon(Icons.close),
                            Text("Unverified", style: TextStyle(fontSize: 12)),
                          ],
                        )
                      : Row(
                          children: [
                            Icon(Icons.check),
                            Text("verified", style: TextStyle(fontSize: 12)),
                          ],
                        ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12),
              decoration: const BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Verifikasi",
                        style: PrimaryTextStyle.judulStyle,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Penanggung Jawab",
                                  style: PrimaryTextStyle.subTxt,
                                ),
                                Text(
                                  "Tanggal",
                                  style: PrimaryTextStyle.subTxt,
                                ),
                                Text(
                                  "Dokter tugas",
                                  style: PrimaryTextStyle.subTxt,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ": ${provDetail.itemRekomendasi!.penanggungJawab}",
                                  style: PrimaryTextStyle.subTxt,
                                ),
                                Text(
                                  ": ${resultTanggal}",
                                  style: PrimaryTextStyle.subTxt,
                                ),
                                Text(
                                  ": ${provDetail.itemRekomendasi!.dokterTugas}",
                                  style: PrimaryTextStyle.subTxt,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                      // Image.asset(
                      //   listBerita[index]["gambar"].toString(),
                      //   fit: BoxFit.contain,
                      // )
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector updateDataKunjungan(KunjunganProvider provDetail,
      BuildContext context, GlobalKey<FormState> formKey) {
    return GestureDetector(
      onTap: () {
        nama = provDetail.item!.nama;
        alamat = provDetail.item!.alamat;
        tinggi = provDetail.item!.tinggi_badan;
        berat = provDetail.item!.berat_badan;
        tekanan_darah = provDetail.item!.tekanan_darah;
        keluhan = provDetail.item!.keluhan;

        showDialog(
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              controller: bbController..text = berat.toString(),
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
                              controller: darahController..text = tekanan_darah,
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
                                provDetail
                                    .fetchDataKunjunganById(widget.whereDocId);

                                Navigator.pop(context);
                                final snackBar = SnackBar(
                                  content: Text('Sukses Update data'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);

                                setState(() {});
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
        );
      },
      child: Text(
        "Ubah",
        style: TextStyle(color: AppTheme.primaryColor),
      ),
    );
  }
}

PreferredSize customAppBar(MediaQueryData mediaquery) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(80.0),
    child: AppBar(
      elevation: 0.3,
      backgroundColor: AppTheme.primaryColor,
      title: const Text("Detail Warga"),
      centerTitle: true,
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(IconlyBroken.info_square),
        )
      ],
    ),
  );
}
