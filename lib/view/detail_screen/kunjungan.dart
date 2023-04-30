import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:posyandu_care_apps/themes/colors.dart';
import 'package:posyandu_care_apps/view/detail_screen/kunjungan_detail.dart';

import '../../models/list_menu.dart';

class Kunjungan extends StatelessWidget {
  final index;
  Kunjungan({super.key, required this.index});
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    // var a = menu[index];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200.0),
        child: AppBar(
          backgroundColor: AppTheme.primaryColor,
          title: Text(menu[index]['judul']),
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 130.0, left: 20, right: 20),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
                width: mediaquery.size.width * 15,
                height: 60,
                alignment: Alignment.center,
                child: TextFormField(
                  initialValue: "Cari data",
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
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: mediaquery.size.height * 1,
            child: Column(
              children: [
                listDataWarga(mediaquery),
                // Spacer(),
              ],
            ),
          )),
      floatingActionButton: ElevatedButton.icon(
          onPressed: () {
            log("add kunjungan warga");
            // showModalBottomSheet(context);
            showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.white,
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0)),
                ),
                builder: (context) {
                  return Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(12),
                          height: 2,
                          width: 100,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                      Container(height: 10),
                      Container(
                        height: 400,
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                            top: 20,
                            left: 20,
                            right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SizedBox(
                            height: 400,
                            child: Form(
                              key: formKey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 40,
                                    child: TextFormField(
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
                                      validator: (value) {},
                                      obscureText: false,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Rt/Rw',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: TextFormField(
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
                                    height: 80,
                                    child: TextFormField(
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
                                    onPressed: () {},
                                    child: Center(
                                      child: Text(
                                        "Done",
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
                          ),
                        ),
                      ),
                    ],
                  );
                });
          },
          icon: const Icon(IconlyBroken.add_user),
          style: ElevatedButton.styleFrom(
              primary: AppTheme.primaryColor), // Background color ,
          label: Text(" Kunjungan")),
    );
  }

  listDataWarga(mediaQuery) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 30.0, left: 10, right: 10, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Data Kunjungan",
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
            itemCount: warga.length,
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
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          log("masuk Ke detail");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => KunjunganDetail(
                                    index: index,
                                  )));
                        },
                        child: SizedBox(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconlyBroken.arrow_right_2,
                                size: 15,
                                color: AppTheme.primaryColor,
                              ),
                              Text("Detail",
                                  style: PrimaryTextStyle.judulStyle),
                            ],
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
