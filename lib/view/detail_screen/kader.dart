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

    return Scaffold(
      appBar: customAppBar(mediaquery),
      backgroundColor: AppTheme.primaryColor,
      body: SizedBox(
        height: mediaquery.size.height * 1,
        child: Column(
          children: [
            listKader(mediaquery),
            // Spacer(),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton.icon(
          onPressed: () {
            var mediaQ = MediaQuery.of(context);

            log("add Kader Posyandu");
            addKader(context, mediaQ);
          },
          icon: Icon(IconlyBroken.add_user),
          style: ElevatedButton.styleFrom(
              primary: AppTheme.primaryColor), // Background color ,
          label: Text("Kader Posyandu")),
    );
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
    return Consumer<KaderProvider>(
      builder: (context, provKader, child) {
        if (provKader.requestState == RequestState.loading) {
          return CircularProgressIndicator();
        } else if (provKader.requestState == RequestState.loaded) {
          final item = provKader.kaderFetched;
          // print(item.nama);
          return Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 20, right: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Data Kader",
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
                    height: mediaQuery.size.height * 0.8,
                    width: mediaQuery.size.width * 5,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      itemCount: provKader.kaderFetched.length,
                      itemBuilder: (context, index) {
                        final item = provKader.kaderFetched[index];
                        // print(item.nama);
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
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (provKader.requestState == RequestState.error) {
          return const Center(
              child: Text("Gagal Mengambil Data, Periksa Akses Internet Mu"));
        } else {
          return const Text("tidak diketahui");
        }
      },
    );
  }

  Future<dynamic> addKader(BuildContext context, mediaQ) {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (context) {
          return Wrap(alignment: WrapAlignment.center, children: [
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
            // Text(
            //   'Tambah Data Kader Posyandu',
            //   style: TextStyle(
            //       color: Colors.grey[600], // Set the text color.
            //       fontSize: 16 // Set the text size.
            //       ),
            // ),
            Container(height: 10),
            Container(
              height: 400,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  height: 900,
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          child: TextFormField(
                            validator: (value) {},
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
                          // width: 400,
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: AppTheme.primaryColor
                                          .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12)),
                                  height: 40,
                                  width: 40,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(IconlyBroken.image),
                                    ],
                                  )
                                  // if null rencana nya
                                  // Image.asset(
                                  //   listBerita[index]["gambar"].toString(),
                                  //   fit: BoxFit.contain,
                                  // )
                                  ),
                              GestureDetector(
                                onTap: () {
                                  log("memilih image");
                                },
                                child: SizedBox(
                                  width: 240,
                                  height: 40,
                                  child: TextFormField(
                                    enabled: false,
                                    validator: (value) {},
                                    obscureText: false,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      // logika kalo terpilih image nya ganti text ke TERPILIH
                                      labelText: 'Pilih Foto',
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
                          clearOption: true,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.always,
                          clearIconProperty: IconProperty(color: Colors.green),
                          searchDecoration: const InputDecoration(
                              hintText: "enter your custom hint text here"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Posisi Perlu Diisi";
                            } else {
                              return null;
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
                          onPressed: () {},
                          child: const Center(
                            child: Text(
                              "Simpan Data Kader",
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
                ),
              ),
            ),
          ]);
        });
  }
}
