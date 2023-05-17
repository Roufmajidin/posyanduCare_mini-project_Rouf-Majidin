import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:posyandu_care_apps/view/kunjungan_page/dialog.dart';
import 'package:posyandu_care_apps/view_model/kunjungan_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/data_kunjungan_model.dart';
import '../../../themes/style.dart';

class KunjunganDetail extends StatefulWidget {
  final String whereDocId;

  KunjunganDetail({Key? key, required this.whereDocId}) : super(key: key);

  @override
  State<KunjunganDetail> createState() => _KunjunganDetailState();
}

Future<SharedPreferences> prefIsLogin = SharedPreferences.getInstance();

class _KunjunganDetailState extends State<KunjunganDetail> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<KunjunganProvider>(context, listen: false)
          .fetchDataKunjunganById(widget.whereDocId),
    );
    // Future.microtask(
    //   () => Provider.of<KunjunganProvider>(context, listen: false)
    //       .fetchDataKunjunganById(loginId),
    // );

    // print(a);
    // get ddetail di collection rekammedis
    getEmail();
  }

  String role = '';
  Future getEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      role = sharedPreferences.getString('email')!;
    });
    print('isemail :{$role}');
  }

  var loginId;
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
        body: SingleChildScrollView(
          child: SizedBox(
              height: mediaquery.size.height,
              child: Consumer<KunjunganProvider>(
                  builder: (context, provDetail, _) {
                Timestamp tanggalKunjugan =
                    provDetail.itemRekomendasi!.tanggalKunjungan;
                DateTime tanggalKunjunganConvert = tanggalKunjugan.toDate();
                String resultTanggal =
                    DateFormat('dd MMMM yyyy').format(tanggalKunjunganConvert);

                if (provDetail.requestState == RequestState.loading) {
                  // provDetail.fetchDataKunjunganById(widget.whereDocId);
                  return const Center(child: CircularProgressIndicator());
                } else if (provDetail.requestState == RequestState.loaded) {
                  // provDetail.fetchDataKunjunganById(widget.whereDocId);
                  if (provDetail.item == null ||
                      provDetail.itemRekomendasi == null) {
                    provDetail.fetchDataKunjunganById(widget.whereDocId);
                    return const Center(child: CircularProgressIndicator());
                  }
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
                                          "Nama :${provDetail.item!.nama.toString()}",
                                          style: PrimaryTextStyle.judulStyle,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Alamat :${provDetail.item!.alamat.toString()}",
                                          style: PrimaryTextStyle.subTxt,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        // updateDataKunjungan(
                                        //     provDetail, context, formKey),
                                        WidgetDialog(
                                          // cek role apakah posyandu atau puskesmas
                                          role: role.toString(),
                                          formKey: formKey,
                                          status: "Update Data",
                                          provDetail: provDetail,
                                        )
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
                                    vertical: 15, horizontal: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              style: TextStyle(
                                                  color: Colors.green),
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
                                    vertical: 60, horizontal: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.spac,
                                      children: [
                                        SizedBox(
                                          width: mediaquery.size.width * 0.9,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Riwayat Obat",
                                                style:
                                                    PrimaryTextStyle.judulStyle,
                                              ),
                                              provDetail.itemRekomendasi!
                                                          .isVerified ==
                                                      true
                                                  ? Text(
                                                      "Verified",
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    )
                                                  : Text(""),
                                            ],
                                          ),
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
                                              width: 160,
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
                                                          style:
                                                              PrimaryTextStyle
                                                                  .subTxt,
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        provDetail.itemRekomendasi!
                                                    .isVerified ==
                                                false
                                            ? WidgetDialog(
                                                // cek role apakah posyandu atau puskesmas
                                                role: role.toString(),
                                                formKey: formKey,
                                                status: "Verifikasi Data",
                                                provDetail: provDetail)
                                            : Text("")
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
              })),
        ));
  }

  // Expanded widgetDetail(KunjunganProvider provDetail, BuildContext context,
  //     GlobalKey<FormState> formKey, String resultTanggal) {
  //   return Expanded(
  //     child: Container(
  //       decoration: BoxDecoration(
  //           color: AppTheme.bgColor,
  //           borderRadius: const BorderRadius.only(
  //               topLeft: Radius.circular(30), topRight: Radius.circular(30))),
  //       child: Column(
  //         children: [
  //           Container(
  //             height: 100,
  //             margin: const EdgeInsets.only(top: 12),
  //             padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Container(
  //                     decoration: BoxDecoration(
  //                         color: Colors.grey.withOpacity(0.2),
  //                         borderRadius: BorderRadius.circular(12)),
  //                     height: 80,
  //                     width: 80,
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: const [
  //                         Icon(IconlyBroken.hide),
  //                         Text("no img")
  //                       ],
  //                     )),
  //                 const SizedBox(
  //                   width: 20,
  //                 ),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       "Nama :${provDetail.item!.nama}",
  //                       style: PrimaryTextStyle.judulStyle,
  //                     ),
  //                     const SizedBox(
  //                       height: 5,
  //                     ),
  //                     Text(
  //                       "Alamat :${provDetail.item!.alamat}",
  //                       style: PrimaryTextStyle.subTxt,
  //                     ),
  //                     const SizedBox(
  //                       height: 20,
  //                     ),
  //                     // updateDataKunjungan(provDetail, context, formKey),
  //                   ],
  //                 ),
  //                 Spacer(),
  //                 GestureDetector(
  //                   onTap: () {
  //                     print("delete data");
  //                     provDetail
  //                         .hapusKunjungan(widget.whereDocId)
  //                         .whenComplete(() => Navigator.pop(context));
  //                     final snackBar = SnackBar(
  //                       content: Text('Sukses Delete data'),
  //                     );
  //                     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //                   },
  //                   child: SizedBox(
  //                     height: 80,
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [Icon(IconlyBroken.delete)],
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //           Container(
  //             margin: const EdgeInsets.only(top: 12),
  //             decoration: const BoxDecoration(color: Colors.white),
  //             padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Container(
  //                     child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       "Details Warga",
  //                       style: PrimaryTextStyle.judulStyle,
  //                     ),
  //                     SizedBox(
  //                       height: 12,
  //                     ),
  //                     Row(
  //                       children: [
  //                         SizedBox(
  //                           width: 120,
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 "Tinggi Badan",
  //                                 style: PrimaryTextStyle.subTxt,
  //                               ),
  //                               Text(
  //                                 "Berat Badan",
  //                                 style: PrimaryTextStyle.subTxt,
  //                               ),
  //                               Text(
  //                                 "Tekanan Darah",
  //                                 style: PrimaryTextStyle.subTxt,
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           width: 100,
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 ": ${provDetail.item!.tinggi_badan.toString()} Cm",
  //                                 style: PrimaryTextStyle.subTxt,
  //                               ),
  //                               Text(
  //                                 ": ${provDetail.item!.berat_badan.toString()} Kg",
  //                                 style: PrimaryTextStyle.subTxt,
  //                               ),
  //                               Text(
  //                                 ": ${provDetail.item!.tekanan_darah.toString()} Bpm",
  //                                 style: PrimaryTextStyle.subTxt,
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     )
  //                   ],
  //                 )
  //                     // Image.asset(
  //                     //   listBerita[index]["gambar"].toString(),
  //                     //   fit: BoxFit.contain,
  //                     // )
  //                     ),
  //                 const SizedBox(
  //                   width: 20,
  //                 ),
  //                 const Spacer(),
  //                 GestureDetector(
  //                   onTap: () {},
  //                   child: const SizedBox(
  //                       height: 80,
  //                       child: Center(
  //                         child: Text(
  //                           "",
  //                           style: TextStyle(color: Colors.green),
  //                         ),
  //                       )),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Container(
  //             margin: const EdgeInsets.only(top: 12),
  //             decoration: const BoxDecoration(color: Colors.white),
  //             padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 8),
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Container(
  //                     // height: 120,
  //                     child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   // mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Text("Verifikasi"),
  //                     Text(
  //                       "Riwayat Obat",
  //                       style: PrimaryTextStyle.judulStyle,
  //                     ),
  //                     const SizedBox(
  //                       height: 12,
  //                     ),
  //                     Row(
  //                       children: [
  //                         SizedBox(
  //                           width: 100,
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 "Tanggal Kunjungan",
  //                                 style: PrimaryTextStyle.subTxt,
  //                               ),
  //                               Text(
  //                                 "Keluhan",
  //                                 style: PrimaryTextStyle.subTxt,
  //                               ),
  //                               Text(
  //                                 "List Obat",
  //                                 style: PrimaryTextStyle.subTxt,
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           width: 80,
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 ": ${resultTanggal}",
  //                                 style: PrimaryTextStyle.subTxt,
  //                               ),
  //                               Text(
  //                                 ": ${provDetail.item!.keluhan}",
  //                                 style: PrimaryTextStyle.subTxt,
  //                               ),
  //                               provDetail.itemRekomendasi!.dataObat == "null"
  //                                   ? const Text(
  //                                       ": Belum terverified",
  //                                       style: TextStyle(
  //                                           color: Colors.redAccent,
  //                                           fontSize: 14),
  //                                     )
  //                                   : Text(
  //                                       ": ${provDetail.itemRekomendasi!.dataObat}",
  //                                       style: PrimaryTextStyle.subTxt,
  //                                     ),
  //                               provDetail.itemRekomendasi!.isVerified == false
  //                                   ? IconButton(
  //                                       onPressed: () {
  //                                         log("Verifikasi Data");
  //                                       },
  //                                       icon: Row(
  //                                         children: [
  //                                           Icon(Icons.close),
  //                                           Text("Verifikasi")
  //                                         ],
  //                                       ))
  //                                   : Row(
  //                                       children: [
  //                                         Icon(
  //                                           Icons.check,
  //                                           color: Colors.green,
  //                                         ),
  //                                         Text("verified",
  //                                             style: TextStyle(
  //                                                 fontSize: 12,
  //                                                 color: Colors.green)),
  //                                       ],
  //                                     ),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     )
  //                   ],
  //                 )
  //                     // Image.asset(
  //                     //   listBerita[index]["gambar"].toString(),
  //                     //   fit: BoxFit.contain,
  //                     // )
  //                     ),

  //                 // Spacer(),
  //                 provDetail.itemRekomendasi!.isVerified == false
  //                     ? Row(
  //                         children: [
  //                           Icon(Icons.close),
  //                           Text("Unverified", style: TextStyle(fontSize: 12)),
  //                         ],
  //                       )
  //                     : Row(
  //                         children: [
  //                           Icon(Icons.check),
  //                           Text("verified", style: TextStyle(fontSize: 12)),
  //                         ],
  //                       ),
  //               ],
  //             ),
  //           ),
  //           Container(
  //             height: 200,
  //             margin: const EdgeInsets.only(top: 12),
  //             decoration: const BoxDecoration(color: Colors.white),
  //             padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Container(
  //                     child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   // mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       "Verifikasi",
  //                       style: PrimaryTextStyle.judulStyle,
  //                     ),
  //                     const SizedBox(
  //                       height: 12,
  //                     ),
  //                     Row(
  //                       children: [
  //                         SizedBox(
  //                           width: 160,
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 "Penanggung Jawab",
  //                                 style: PrimaryTextStyle.subTxt,
  //                               ),
  //                               Text(
  //                                 "Tanggal",
  //                                 style: PrimaryTextStyle.subTxt,
  //                               ),
  //                               Text(
  //                                 "Dokter tugas",
  //                                 style: PrimaryTextStyle.subTxt,
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           width: 150,
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 ": ${provDetail.itemRekomendasi!.penanggungJawab}",
  //                                 style: PrimaryTextStyle.subTxt,
  //                               ),
  //                               Text(
  //                                 ": ${resultTanggal}",
  //                                 style: PrimaryTextStyle.subTxt,
  //                               ),
  //                               Text(
  //                                 ": ${provDetail.itemRekomendasi!.dokterTugas}",
  //                                 style: PrimaryTextStyle.subTxt,
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     )
  //                   ],
  //                 )),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // GestureDetector updateDataKunjungan(KunjunganProvider provDetail,
  //     BuildContext context, GlobalKey<FormState> formKey) {
  //   return
  // }
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
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(IconlyBroken.info_square),
        )
      ],
    ),
  );
}
