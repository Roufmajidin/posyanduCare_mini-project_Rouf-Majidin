import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posyandu_care_apps/themes/style.dart';
import 'package:posyandu_care_apps/view_model/artikel_provider.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class ArtikelDetail extends StatefulWidget {
  final String docId;

  ArtikelDetail({super.key, required this.docId});

  @override
  State<ArtikelDetail> createState() => _ArtikelDetailState();
}

class _ArtikelDetailState extends State<ArtikelDetail> {
  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<ArtikelProvider>(context, listen: false)
          .fetchDataArtikelById(widget.docId),
    );
  }

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
        physics: ScrollPhysics(),
        child:
            Consumer<ArtikelProvider>(builder: (context, artikelProvider, _) {
          if (artikelProvider.requestState == RequestState.loading) {
            // provDetail.fetchDataKunjunganById(widget.whereDocId);

            return const Center(child: CircularProgressIndicator());
          } else if (artikelProvider.requestState == RequestState.loaded) {
            return Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: height * .3,
                      width: width,
                      child: Image.network(
                        artikelProvider.detailArtikel!.image,
                        fit: BoxFit.fitWidth,
                      ),
                      decoration: BoxDecoration(
                          // color: Colors.green,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            artikelProvider.detailArtikel!.judulArtikel,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 80, 80, 80)),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            artikelProvider.detailArtikel!.tanggalPublish,
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
                                padding: EdgeInsets.all(5),
                                height: height,
                                child: ReadMoreText(
                                    artikelProvider.detailArtikel!.isiArtikel,
                                    trimLines: 14,
                                    textAlign: TextAlign.justify,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: "baca Lebih Lanjut",
                                    moreStyle:
                                        TextStyle(color: AppTheme.primaryColor),
                                    lessStyle:
                                        TextStyle(color: AppTheme.primaryColor),
                                    style: PrimaryTextStyle.subTxt),
                              )),
                        ],
                      ),
                    )
                  ],
                )
              ],
            );
          }
          if (artikelProvider.requestState == RequestState.error) {
            return const Center(
                child: Text("Gagal Mengambil Data, Periksa Akses Internet Mu"));
          } else {
            return const Text("tidak diketahui");
          }
        }),
      ),
    );
  }
}
