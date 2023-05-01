import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posyandu_care_apps/themes/colors.dart';
import 'package:posyandu_care_apps/view/detail_screen/kunjungan_detail.dart';
import 'package:readmore/readmore.dart';

import '../../models/list_menu.dart';

class ArtikelDetail extends StatelessWidget {
  final index;

  ArtikelDetail({super.key, required this.index});
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

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
        physics: NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: height * .3,
                    width: width,
                    child: Image.asset(
                      listBerita[index]['gambar'],
                      fit: BoxFit.fitWidth,
                    ),
                    decoration: BoxDecoration(
                        // color: Colors.green,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.bgColor,
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
                                child: Container(
                                  height: height * .5,
                                  child: ReadMoreText(listBerita[index]["isi"],
                                      trimLines: 10,
                                      textAlign: TextAlign.justify,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: "baca Lebih Lanjut",
                                      moreStyle: TextStyle(
                                          color: AppTheme.primaryColor),
                                      lessStyle: TextStyle(
                                          color: AppTheme.primaryColor),
                                      style: PrimaryTextStyle.subTxt),
                                )),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
