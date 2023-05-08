import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:posyandu_care_apps/models/artikel_model.dart';

import '../themes/style.dart';
import '../view/detail_screen/artikel_detail.dart';

class ArtikelWiget extends StatelessWidget {
  const ArtikelWiget({
    super.key,
    required this.artikel,
  });

  final ArtikelModel artikel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Card(
        // wrap ke padding, :)
        elevation: 0.9,
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
                      artikel.judulArtikel,
                      style: PrimaryTextStyle.judulStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        artikel.tanggalPublish,
                        style: PrimaryTextStyle.subTxt,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.circle,
                        size: 5,
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
                      GestureDetector(
                        onTap: () {
                          log("Ke detail Artikel Kesehatan");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ArtikelDetail(
                                    docId: artikel.docId,
                                  )));
                        },
                        child: Text(
                          "Baca lebih lanjut",
                          style: TextStyle(color: AppTheme.primaryColor),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      // color: Color.fromARGB(255, 189, 187, 187)
                      //     .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12)),
                  height: 100,
                  width: 100,
                  child: artikel.image == ""
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconlyBroken.hide),
                            Text(artikel.image)
                          ],
                        )
                      : Image.network(
                          artikel.image.toString(),
                          fit: BoxFit.cover,
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
