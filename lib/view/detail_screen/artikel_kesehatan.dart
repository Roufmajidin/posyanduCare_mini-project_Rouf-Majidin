import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:posyandu_care_apps/themes/colors.dart';

import '../../models/list_menu.dart';

class ArtikelKesehatan extends StatelessWidget {
  ArtikelKesehatan({super.key});
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    // var a = menu[index];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: AppTheme.primaryColor,
          title: const Text("Artikel Kesehatan"),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              listArtikelKesehatan(mediaquery),
              // Spacer(),
            ],
          )),
      floatingActionButton: ElevatedButton.icon(
          onPressed: () {
            log(" Link ke add Artikel");
            // showModalBottomSheet(context);
          },
          icon: const Icon(IconlyBroken.add_user),
          style: ElevatedButton.styleFrom(
              primary: AppTheme.primaryColor), // Background color ,
          label: Text(" Add Artikel")),
    );
  }

  listArtikelKesehatan(mediaQuery) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        SizedBox(
          height: mediaQuery.size.height * 5,
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 20),
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            itemCount: listBerita.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: Card(
                  // wrap ke padding, :)
                  elevation: 0.1,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                listBerita[index]["judulBerita"],
                                style: PrimaryTextStyle.judulStyle,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  listBerita[index]["tanggal"],
                                  style: PrimaryTextStyle.subTxt,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(
                                  Icons.circle,
                                  size: 5,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  listBerita[index]["waktu_pub"],
                                  style: PrimaryTextStyle.subTxt,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  IconlyBroken.arrow_right_2,
                                  size: 10,
                                  color: AppTheme.primaryColor,
                                ),
                                Text(
                                  "Read more for read",
                                  style:
                                      TextStyle(color: AppTheme.primaryColor),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 189, 187, 187)
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12)),
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(IconlyBroken.hide),
                                Text("no image")
                              ],
                            )
                            // Image.asset(
                            //   listBerita[index]["gambar"].toString(),
                            //   fit: BoxFit.contain,
                            // )
                            )
                      ],
                    ),
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
