import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:posyandu_care_apps/themes/colors.dart';
import 'package:posyandu_care_apps/view/detail_screen/kunjungan_detail.dart';

import '../../models/list_menu.dart';

class KaderPage extends StatelessWidget {
  final index;
  KaderPage({super.key, required this.index});
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    // var a = menu[index];

    return Scaffold(
      appBar: customAppBar(mediaquery),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: mediaquery.size.height * 1,
            child: Column(
              children: [
                listKader(mediaquery),
                // Spacer(),
              ],
            ),
          )),
      floatingActionButton: ElevatedButton.icon(
          onPressed: () {
            log("add Kader Posyandu");
            addKader(context);
          },
          icon: Icon(IconlyBroken.add_user),
          style: ElevatedButton.styleFrom(
              primary: AppTheme.primaryColor), // Background color ,
          label: Text("Kader Posyandu")),
    );
  }

  PreferredSize customAppBar(MediaQueryData mediaquery) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(200.0),
      child: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text(menu[index]['judul']),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(IconlyBroken.info_circle),
          )
        ],
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 130.0, left: 20, right: 20),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
              width: mediaquery.size.width * 15,
              height: 40,
              alignment: Alignment.center,
              child: TextFormField(
                initialValue: "Cari data Kader",
                decoration: InputDecoration(
                  // fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintText: "Search",

                  enabledBorder: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide:
                          const BorderSide(width: 2, color: Colors.white)),
                ),
              )),
        ),
      ),
    );
  }

  Future<dynamic> addKader(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (context) {
          return Container(
            height: 250,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                height: 900,
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {},
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nama Kader',
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
                      const SizedBox(
                        height: 12,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: AppTheme.primaryColor),
                        onPressed: () {},
                        child: Center(
                          child: Text(
                            "Simpan Data Kader",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
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
  }

  listKader(mediaQuery) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 30.0, left: 10, right: 10, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Data Kader",
                style: PrimaryTextStyle.judulStyle,
              ),
              Column(
                children: const [
                  Icon(
                    Icons.circle,
                    size: 5,
                  ),
                  Icon(
                    Icons.circle,
                    size: 5,
                  ),
                  Icon(
                    Icons.circle,
                    size: 5,
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 600,
          width: mediaQuery.size.width * 5,
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 20),
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            itemCount: kader.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 0.2,
                child: Container(
                  padding: const EdgeInsets.all(12),
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
                              Text("Image Kader")
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
                            kader[index]["namaKader"],
                            style: PrimaryTextStyle.judulStyle,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            kader[index]["posisiJabatan"],
                            style: PrimaryTextStyle.subTxt,
                          ),
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          log("masuk Ke detail Kader");
                        },
                        child: const SizedBox(
                          height: 40,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Icon(
                              IconlyBroken.arrow_right_2,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
