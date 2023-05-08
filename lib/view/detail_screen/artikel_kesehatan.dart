import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:posyandu_care_apps/models/artikel_model.dart';
import 'package:posyandu_care_apps/themes/style.dart';
import 'package:posyandu_care_apps/view/detail_screen/artikel_detail.dart';
import 'package:provider/provider.dart';

import '../../models/list_menu.dart';
import '../../view_model/artikel_provider.dart';
import '../../widget/artikel.dart';

class ArtikelKesehatan extends StatefulWidget {
  ArtikelKesehatan({super.key});

  @override
  State<ArtikelKesehatan> createState() => _ArtikelKesehatanState();
}

class _ArtikelKesehatanState extends State<ArtikelKesehatan> {
  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<ArtikelProvider>(context, listen: false)
          .fetchDataArtikel(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    // var a = menu[index];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0.3,
          backgroundColor: AppTheme.primaryColor,
          title: const Text(
            "Artikel Kesehatan",
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(IconlyBroken.info_square),
            )
          ],
        ),
      ),
      backgroundColor: AppTheme.primaryColor,
      body: Container(
        height: mediaquery.size.height * 4,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Consumer<ArtikelProvider>(
          builder: (context, artikelProvider, child) {
            if (artikelProvider.requestState == RequestState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (artikelProvider.requestState == RequestState.loaded) {
              final item = artikelProvider.dataArtikelFetched;
              return SizedBox(
                // height: mediaquery.size.height * 5,
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  itemCount: artikelProvider.dataArtikelFetched.length,
                  itemBuilder: (context, index) {
                    final artikel = artikelProvider.dataArtikelFetched[index];
                    return ArtikelWiget(artikel: artikel);
                  },
                ),
              );
            }
            if (artikelProvider.requestState == RequestState.error) {
              return const Center(
                  child:
                      Text("Gagal Mengambil Data, Periksa Akses Internet Mu"));
            } else {
              return const Text("tidak diketahui");
            }
          },
        ),
      ),
    );
  }
}
