import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posyandu_care_apps/themes/colors.dart';
import 'package:posyandu_care_apps/view/detail_screen/kunjungan_detail.dart';

import '../../models/list_menu.dart';

class ArtikelDetail extends StatelessWidget {
  final index;

  ArtikelDetail({super.key, required this.index});
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    // var a = menu[index];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: AppTheme.bgColor,
          shadowColor: AppTheme.bgColor,
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: mediaquery.size.height * 1, //70 for bottom
            child: Stack(
              children: [
                Positioned(
                  top: -600,
                  bottom: 20, // to shift little up
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    listBerita[index]['gambar'],
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                    top: 250,
                    height: 900,
                    left: 0,
                    right: 0,
                    child: Container(
                      // width: mediaquery.size.width * 2,
                      decoration: BoxDecoration(
                        color: AppTheme.bgColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              listBerita[index]["judulBerita"],
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 80, 80, 80)),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              listBerita[index]["tanggal"],
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 80, 80, 80)),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            SingleChildScrollView(
                              physics: ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              child: SizedBox(
                                height: 600,
                                child: Text(
                                  listBerita[index]["isi"],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 80, 80, 80)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          )),
    );
  }
}
