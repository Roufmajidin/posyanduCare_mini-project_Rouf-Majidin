import 'dart:developer';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:posyandu_care_apps/models/kader_model.dart';
import 'package:posyandu_care_apps/themes/colors.dart';
import 'package:posyandu_care_apps/view/detail_screen/kader_detail.dart';
import 'package:posyandu_care_apps/view/detail_screen/kunjungan_detail.dart';
import 'package:posyandu_care_apps/view_model/kader_provider.dart';
import 'package:provider/provider.dart';

import '../../models/list_menu.dart';

class KaderPage extends StatefulWidget {
  final index;

  KaderPage({super.key, required this.index});

  @override
  State<KaderPage> createState() => _KaderPageState();
}

class _KaderPageState extends State<KaderPage> {
  var formKey = GlobalKey<FormState>();
  // String gambarKader = '';
  String posisiKader = '';
  String gambarKader = '';
  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController gambarController = TextEditingController();
  final TextEditingController jabatanController = TextEditingController();

  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<KaderProvider>(context, listen: false).fetchDataKader(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    // var a = menu[index];
    var kaderProv = Provider.of<KaderProvider>(context, listen: false);

    return Scaffold(
        appBar: customAppBar(mediaquery),
        backgroundColor: AppTheme.primaryColor,
        body: SizedBox(
            height: mediaquery.size.height * 1,
            child: Column(
              children: [
                listKader(mediaquery),
              ],
            )),
        floatingActionButton: addDataKader(context, mediaquery, kaderProv));
  }

  ElevatedButton addDataKader(BuildContext context, MediaQueryData mediaquery,
      KaderProvider kaderProv) {
    return ElevatedButton.icon(
        onPressed: () {
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: 40,
                              child: TextFormField(
                                autofocus: true,
                                controller: namaController,
                                obscureText: false,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Nama Kader',
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: AppTheme.primaryColor
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      height: 40,
                                      width: 40,
                                      child: Consumer<KaderProvider>(
                                        builder: (context, proviKader, _) =>
                                            Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            proviKader == ""
                                                ? Container(
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        color: AppTheme
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                  )
                                                : SizedBox(
                                                    height: 40,
                                                    child: Image.network(
                                                      proviKader
                                                          .gambarKaderUpdate,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  )
                                          ],
                                        ),
                                      )
                                      // if null rencana nya
                                      //
                                      ),
                                  GestureDetector(
                                    onTap: () async {
                                      log("memilih image");

                                      kaderProv.updatepickImage();
                                      setState(() {
                                        log("dan image terupdate");
                                        gambarKader == kaderProv.gambarKader;
                                        print("Updated");
                                      });
                                    },
                                    child: SizedBox(
                                      width: 240,
                                      height: 40,
                                      child: TextFormField(
                                        controller: gambarController,
                                        enabled: false,
                                        validator: (value) {},
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          // logika kalo terpilih image nya ganti text ke TERPILIH
                                          labelText: kaderProv.gambarKader == ''
                                              ? "pilih image"
                                              : "image Terpilih",
                                          labelStyle:
                                              TextStyle(color: Colors.green),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            DropDownTextField(
                              dropDownItemCount: 2,
                              initialValue: posisiKader,
                              clearOption: true,
                              keyboardType: TextInputType.number,
                              autovalidateMode: AutovalidateMode.always,
                              clearIconProperty:
                                  IconProperty(color: Colors.green),
                              searchDecoration: const InputDecoration(
                                  hintText: "enter your custom hint text here"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Posisi Perlu Diisi";
                                } else {
                                  kaderProv.posisiKader = value;

                                  // return null;
                                }
                              },
                              dropDownList: const [
                                DropDownValueModel(
                                    name: 'ketua Posyandu', value: "Ketua"),
                                DropDownValueModel(
                                    name: 'Anggota', value: "Anggota")
                              ],
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
                                kaderProv
                                    .addDataKader(DataKaderModels(
                                        docId: id,
                                        nama: namaController.text,
                                        alamat: alamatController.text,
                                        verfiedAt: false,
                                        jabatan: kaderProv.posisiKader,
                                        image: kaderProv.gambarKaderUpdate))
                                    .whenComplete(() {
                                  Navigator.pop(context);
                                  final snackBar = SnackBar(
                                    content: Text('Sukses Add Data'),
                                    duration: Duration(seconds: 4),
                                    action: SnackBarAction(
                                      label: 'Undo',
                                      onPressed: () {
                                        setState(() {});
                                      },
                                    ),
                                  );

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  setState(() {
                                    namaController.clear();
                                    alamatController.clear();
                                    jabatanController.clear();
                                    kaderProv.gambarKaderUpdate = '';
                                    kaderProv.posisiKader = '';
                                  });
                                });
                              },
                              child: const Center(
                                child: Text(
                                  "Add Data Kader",
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
                    ]),
                  ),
                ),
              );
            },
          );
        },
        icon: Icon(IconlyBroken.add_user),
        style: ElevatedButton.styleFrom(
            primary: AppTheme.primaryColor), // Background color ,
        label: Text("Kader Posyandu"));
  }

  PreferredSize customAppBar(MediaQueryData mediaquery) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80.0),
      child: AppBar(
        elevation: 0.3,
        backgroundColor: AppTheme.primaryColor,
        title: Text(menu[widget.index]['judul']),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(IconlyBroken.info_square),
          )
        ],
      ),
    );
  }

  listKader(mediaQuery) {
    return Expanded(
      child: Container(
        height: mediaQuery.size.height * 5,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  // color: Colors.grey,
                  borderRadius: BorderRadius.circular(12)),
              width: mediaQuery.size.width * 0.9,
              height: 40,
              alignment: Alignment.center,
              child: TextFormField(
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
                    "Data Kaders",
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
            Expanded(
              child:
                  Consumer<KaderProvider>(builder: (context, kaderProv, child) {
                if (kaderProv.requestState == RequestState.loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (kaderProv.requestState == RequestState.loaded) {
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 1),
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    itemCount: kaderProv.kaderFetched.length,
                    itemBuilder: (context, index) {
                      final item = kaderProv.kaderFetched[index];
                      // print(item.nama);

                      if (kaderProv.kaderFetched != null) {
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
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    height: 80,
                                    width: 80,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                      item.nama,
                                      style: PrimaryTextStyle.judulStyle,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      item.jabatan,
                                      style: PrimaryTextStyle.subTxt,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    log("masuk Ke detail Kader");
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => KaderDetail(
                                                  index: item.docId,
                                                )));
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
                      } else {
                        kaderProv.fetchDataKader();
                      }
                    },
                  );
                }
                if (kaderProv.requestState == RequestState.error) {
                  return const Center(
                      child: Text(
                          "Gagal Mengambil Data, Periksa Akses Internet Mu"));
                } else {
                  return const Text("tidak diketahui");
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
