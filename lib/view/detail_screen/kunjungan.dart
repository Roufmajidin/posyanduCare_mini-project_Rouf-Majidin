import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:posyandu_care_apps/themes/colors.dart';

import '../../models/list_menu.dart';

class Kunjungan extends StatelessWidget {
  final index;
  const Kunjungan({super.key, required this.index});

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
          },
          icon: Icon(IconlyBroken.add_user),
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
              return Column(
                children: [
                  Container(
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
                        SizedBox(
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
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
