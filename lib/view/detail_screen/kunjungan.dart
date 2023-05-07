import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:posyandu_care_apps/models/data_kunjungan_model.dart';
import 'package:posyandu_care_apps/themes/colors.dart';
import 'package:posyandu_care_apps/view/detail_screen/kunjungan_detail.dart';
import 'package:provider/provider.dart';

import '../../models/list_menu.dart';
import '../../view_model/kunjungan_provider.dart';

class Kunjungan extends StatefulWidget {
  final index;
  Kunjungan({super.key, required this.index});

  @override
  State<Kunjungan> createState() => _KunjunganState();
}

class _KunjunganState extends State<Kunjungan> {
  var formKey = GlobalKey<FormState>();
  late TextEditingController namaController = TextEditingController();
  late TextEditingController alamatController = TextEditingController();
  late TextEditingController bbController = TextEditingController();
  late TextEditingController tinggiController = TextEditingController();
  late TextEditingController darahController = TextEditingController();
  late TextEditingController keluhanController = TextEditingController();
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<KunjunganProvider>(context, listen: false)
          .fetchDataKunjungan(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: AppTheme.primaryColor,
          centerTitle: true,
          title: Text(menu[widget.index]['judul']),
          elevation: 0.6,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(IconlyBroken.info_square),
            )
          ],
        ),
      ),
      backgroundColor: AppTheme.primaryColor,
      body: SizedBox(
        height: mediaquery.size.height * 1,
        child: Column(
          children: [
            listDataWarga(mediaquery),
            // Spacer(),
          ],
        ),
      ),
      floatingActionButton: addDataKunjungan(context, mediaquery),
    );
  }

  ElevatedButton addDataKunjungan(
      BuildContext context, MediaQueryData mediaquery) {
    return ElevatedButton.icon(
        onPressed: () {
          log("add kunjungan warga");
          showDialog(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                icon: Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.close),
                    ),
                  );
                }),
                insetPadding: EdgeInsets.all(8),
                content: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: SizedBox(
                    width: mediaquery.size.height,
                    // form widget
                    child: Column(children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(12),
                        height: 2,
                        width: 100,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Add Data Kader Posyandu',
                        style: TextStyle(
                            color: Colors.grey[600], // Set the text color.
                            fontSize: 16 // Set the text size.
                            ),
                      ),
                      const SizedBox(height: 10),
                      Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40,
                              child: TextFormField(
                                controller: namaController,
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
                                controller: alamatController,
                                validator: (value) {},
                                obscureText: false,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Alamat',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            SizedBox(
                              height: 40,
                              child: TextFormField(
                                controller: bbController,
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
                                controller: tinggiController,
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
                              height: 40,
                              child: TextFormField(
                                controller: darahController,
                                validator: (value) {},
                                obscureText: false,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Tekanan Darah (Bpm)',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            SizedBox(
                              height: 80,
                              child: TextFormField(
                                controller: keluhanController,
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
                              onPressed: () {
                                String id = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString();

                                DataKunjunganModel addData = DataKunjunganModel(
                                  doc_id: id,
                                  nama: namaController.text,
                                  alamat: alamatController.text,
                                  berat_badan: int.parse(bbController.text),
                                  tinggi_badan:
                                      int.parse(tinggiController.text),
                                  tekanan_darah: darahController.text,
                                  keluhan: keluhanController.text,
                                );
                                Future.microtask(
                                  () => Provider.of<KunjunganProvider>(context,
                                          listen: false)
                                      .addDataKunjungan(addData),
                                ).whenComplete(() {
                                  namaController.clear();
                                  alamatController.clear();
                                  bbController.clear();
                                  tinggiController.clear();
                                  darahController.clear();
                                  keluhanController.clear();
                                  Navigator.pop(context);

                                  final snackBar = SnackBar(
                                    content: Text('Sukses Add data'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);

                                  setState(() {});
                                  return snackBar;
                                });
                              },
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
                    ]),
                  ),
                ),
              );
            },
          );
        },
        icon: const Icon(IconlyBroken.add_user),
        style: ElevatedButton.styleFrom(
            primary: AppTheme.primaryColor), // Background color ,
        label: Text(" Kunjungan"));
  }

  listDataWarga(mediaquery) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: AppTheme.bgColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  // color: Colors.grey,
                  borderRadius: BorderRadius.circular(12)),
              width: mediaquery.size.width * 0.9,
              height: 40,
              alignment: Alignment.center,
              child: TextFormField(
                validator: (value) {
                  // if (n.hasMatch(value)) {
                  //   return "Nama harus benar";
                  // }
                },
                obscureText: false,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  labelText: 'Cari Data',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 30.0, left: 10, right: 10, bottom: 20),
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
            Expanded(child:
                Consumer<KunjunganProvider>(builder: (context, prov, child) {
              if (prov.requestState == RequestState.loading) {
                return CircularProgressIndicator();
              } else if (prov.requestState == RequestState.loaded) {
                final item = prov.dataKunjunganfetched;
                return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 20),
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  itemCount: prov.dataKunjunganfetched.length,
                  itemBuilder: (context, index) {
                    final item = prov.dataKunjunganfetched[index];
                    return Card(
                      elevation: 0.9,
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
                                  item.nama,
                                  style: PrimaryTextStyle.judulStyle,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'alamat : ${item.alamat}',
                                  style: PrimaryTextStyle.subTxt,
                                ),
                              ],
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                log(item.doc_id.toString());
                                log("masuk Ke detail");
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => KunjunganDetail(
                                          whereDocId: item.doc_id,
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
                );
              }
              if (prov.requestState == RequestState.error) {
                return const Center(
                    child: Text(
                        "Gagal Mengambil Data, Periksa Akses Internet Mu"));
              } else {
                return const Text("tidak diketahui");
              }
            })),
          ],
        ),
      ),
    );
  }
}
