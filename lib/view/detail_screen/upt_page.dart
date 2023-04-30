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
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
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
      backgroundColor: AppTheme.bgColor,
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          profilUpt(mediaquery),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Keterangan",
              style: PrimaryTextStyle.judulStyle,
            ),
          ),
          keteranganWidget(mediaquery),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Dokter Tugas",
              style: PrimaryTextStyle.judulStyle,
            ),
          ),
          dokterTugasWidget(mediaquery),
        ],
      )),
    );
  }

  keteranganWidget(MediaQueryData mediaquery) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 239, 238, 238),
            borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.only(top: 12, left: 12),
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
    );
  }

  dokterTugasWidget(MediaQueryData mediaquery) {
    return Padding(
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
    );
  }

  profilUpt(MediaQueryData mediaquery) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 150,
        width: mediaquery.size.width * 1,
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
    );
  }
}
