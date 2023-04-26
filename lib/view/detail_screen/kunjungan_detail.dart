import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../models/list_menu.dart';
import '../../themes/colors.dart';

class KunjunganDetail extends StatelessWidget {
  final index;

  const KunjunganDetail({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    var formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: AppTheme.primaryColor,
          title: Text("Detail Warga"),
        ),
      ),
      backgroundColor: AppTheme.bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              margin: const EdgeInsets.only(top: 12),
              decoration: const BoxDecoration(color: Colors.white),
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
                      )
                      // Image.asset(
                      //   listBerita[index]["gambar"].toString(),
                      //   fit: BoxFit.contain,
                      // )
                      ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        warga[index]["namaWarga"],
                        style: PrimaryTextStyle.judulStyle,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        warga[index]["blok"],
                        style: PrimaryTextStyle.subTxt,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25.0)),
                              ),
                              builder: (context) {
                                return Container(
                                  height: 500,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: SizedBox(
                                      height: 900,
                                      child: Form(
                                        key: formKey,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              validator: (value) {},
                                              obscureText: false,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Nama Warga',
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            TextFormField(
                                              validator: (value) {},
                                              obscureText: false,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Rt/Rw',
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            TextFormField(
                                              validator: (value) {},
                                              obscureText: false,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Berat Badan (Kg)',
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            TextFormField(
                                              validator: (value) {},
                                              obscureText: false,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Tinggi Badan (Cm)',
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            TextFormField(
                                              validator: (value) {},
                                              obscureText: false,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Keluhan',
                                              ),
                                              maxLines: 4,
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary:
                                                      AppTheme.primaryColor),
                                              onPressed: () {},
                                              child: const Center(
                                                child: Text(
                                                  "Done",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Text(
                          "Ubah",
                          style: TextStyle(color: AppTheme.primaryColor),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {},
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
                                  ": 180 Cm",
                                  style: PrimaryTextStyle.subTxt,
                                ),
                                Text(
                                  ": 50 Kg",
                                  style: PrimaryTextStyle.subTxt,
                                ),
                                Text(
                                  ": 120/10 Bpm",
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
                  Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                        height: 80,
                        child: Center(
                          child: Text(
                            "Ideal",
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
                            width: 130,
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
                                  ": 27 Februari 2023",
                                  style: PrimaryTextStyle.subTxt,
                                ),
                                Text(
                                  ": sakit mata, gatal kulit",
                                  style: PrimaryTextStyle.subTxt,
                                ),
                                Text(
                                  ": Paracetamol",
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
                  const SizedBox(
                    width: 5,
                  ),
                  // Spacer(),
                  Row(
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
                                  "Penanggun Jawab",
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
                                  ": UPT. Dukupuntang",
                                  style: PrimaryTextStyle.subTxt,
                                ),
                                Text(
                                  ": 28 Februari 2023",
                                  style: PrimaryTextStyle.subTxt,
                                ),
                                Text(
                                  ": Rouf  Majid, Amd. Kep",
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
}
