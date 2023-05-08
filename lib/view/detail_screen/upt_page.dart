import 'dart:developer';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:posyandu_care_apps/models/list_menu.dart';

import '../../themes/colors.dart';

class UptPage extends StatefulWidget {
  final index;
  UptPage({super.key, required this.index});
  var formKey = GlobalKey<FormState>();

  @override
  State<UptPage> createState() => _UptPageState();
}

class _UptPageState extends State<UptPage> {
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0.3,
          backgroundColor: AppTheme.primaryColor,
          title: const Text(
            "Data UPT",
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(IconlyBroken.info_circle),
            )
          ],
        ),
      ),
      backgroundColor: AppTheme.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          profilUpt(mediaquery),
        ],
      ),
    );
  }

  keteranganWidget(MediaQueryData mediaquery) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Keterangan",
            style: PrimaryTextStyle.judulStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 239, 238, 238),
                borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.only(top: 12, left: 12),
            height: 150,
            width: mediaquery.size.width * 1,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 240,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 6.0),
                                child: Icon(
                                  IconlyBroken.edit,
                                  size: 18,
                                ),
                              ),
                              Text(
                                "Titik Posyandu",
                                style: PrimaryTextStyle.thirdStyle,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Posyandu Cempaka Mulya",
                            style: PrimaryTextStyle.subTxt,
                          ),
                          Row(
                            children: [
                              Text(
                                "Desa : ",
                                style: PrimaryTextStyle.subTxt,
                              ),
                              Text(
                                "Kedongdong Kidul",
                                style: PrimaryTextStyle.subTxt,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  dokterTugasWidget(MediaQueryData mediaquery) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Dokter Tugas",
            style: PrimaryTextStyle.judulStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 239, 238, 238),
                borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.only(
              top: 12,
              left: 12,
            ),
            height: 80,
            width: mediaquery.size.width * 1,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 240,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 6.0),
                                child: Icon(
                                  IconlyBroken.user_2,
                                  size: 18,
                                ),
                              ),
                              Text(
                                "Dokter Pembina Posyandu",
                                style: PrimaryTextStyle.thirdStyle,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Shinta Laveny, Amd. Kep",
                            style: PrimaryTextStyle.subTxt,
                          ),
                          Row(
                            children: [
                              Text(
                                "Titik Posyandu : ",
                                style: PrimaryTextStyle.subTxt,
                              ),
                              Text(
                                "Cempaka Mulya",
                                style: PrimaryTextStyle.subTxt,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer()
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  detailUpt(MediaQueryData mediaquery) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Detail UPT",
            style: PrimaryTextStyle.judulStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 239, 238, 238),
                borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.only(
              top: 12,
              left: 12,
            ),
            height: 250,
            width: mediaquery.size.width * 1,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: mediaquery.size.width * 0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 6.0),
                                child: Icon(
                                  IconlyBroken.user_2,
                                  size: 18,
                                ),
                              ),
                              Text(
                                "UPT Dukupuntang",
                                style: PrimaryTextStyle.thirdStyle,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Alamat",
                                        style: PrimaryTextStyle.subTxt,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Kode Pos",
                                        style: PrimaryTextStyle.subTxt,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Kecamatan",
                                        style: PrimaryTextStyle.subTxt,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Kabupaten",
                                        style: PrimaryTextStyle.subTxt,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "No. Bangunan",
                                        style: PrimaryTextStyle.subTxt,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        ": Jl. Nyi mas Tepak Sari",
                                        style: PrimaryTextStyle.subTxt,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        ": 45652",
                                        style: PrimaryTextStyle.subTxt,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        ": Dukupuntang",
                                        style: PrimaryTextStyle.subTxt,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        ": Cirebon",
                                        style: PrimaryTextStyle.subTxt,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        ": X-0912-V",
                                        style: PrimaryTextStyle.subTxt,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer()
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  profilUpt(MediaQueryData mediaquery) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 50),
          // height: 200,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(129, 158, 158, 158),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Icon(
                        IconlyBroken.paper_fail,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "UPT Puskesmas Dukupuntang",
                            style: PrimaryTextStyle.judulStyle,
                          ),
                          const Text("Kecamatan Dupuntang"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              detailUpt(mediaquery),
              keteranganWidget(mediaquery),
              dokterTugasWidget(mediaquery),
            ],
          ),
        ),
      ),
    );
  }
}
