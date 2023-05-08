import 'dart:developer';
import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:posyandu_care_apps/models/list_menu.dart';
import 'package:posyandu_care_apps/view_model/kader_provider.dart';
import 'package:provider/provider.dart';

import '../../models/kader_model.dart';
import '../../themes/style.dart';

class KaderDetail extends StatefulWidget {
  final String index;
  KaderDetail({super.key, required this.index});
  var formKey = GlobalKey<FormState>();

  @override
  State<KaderDetail> createState() => _KaderDetailState();
}

class _KaderDetailState extends State<KaderDetail> {
  var onTapped = false;
  var onTapStatusEdit = false;
  var onTapStatusHapus = false;

  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController gambarController = TextEditingController();
  final TextEditingController jabatanController = TextEditingController();
  final TextEditingController dropdownController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<KaderProvider>(context, listen: false)
          .fetchKaderById(widget.index),
    );
    // get ddetail di collection rekammedis
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    var formKey = GlobalKey<FormState>();

    String posisiKader = '';
    late String gambarKader = '';
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: AppTheme.primaryColor,
          title: const Text("Detail Kader"),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(IconlyBroken.info_square),
            )
          ],
        ),
      ),
      backgroundColor: AppTheme.bgColor,
      body: SingleChildScrollView(
          child: Consumer<KaderProvider>(builder: (context, provKader, _) {
        if (provKader.requestState == RequestState.loading) {
          // provDetail.fetchDataKunjunganById(widget.whereDocId);

          return const Center(child: CircularProgressIndicator());
        } else if (provKader.requestState == RequestState.loaded) {
          provKader.fetchKaderById(widget.index);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // profileDetail(mediaquery, provKader),
              widgetProfile(mediaquery, provKader, context, gambarKader,
                  posisiKader, formKey),
              posisiDetail(mediaquery, provKader),
              alamatDetail(mediaquery, provKader),
              statusDetail(mediaquery, provKader),
            ],
          );
        }
        if (provKader.requestState == RequestState.error) {
          return const Center(
              child: Text("Gagal Mengambil Data, Periksa Akses Internet Mu"));
        } else {
          return const Text("tidak diketahui");
        }
      })),
    );
  }

  Container widgetProfile(
      MediaQueryData mediaquery,
      KaderProvider provKader,
      BuildContext context,
      String gambarKader,
      String posisiKader,
      GlobalKey<FormState> formKey) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 12),
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 239, 238, 238)),
      padding: const EdgeInsets.only(top: 20, left: 12),
      height: 150,
      width: mediaquery.size.width * 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              width: 70,
              height: 70,
              color: Color.fromARGB(255, 195, 195, 195),
              child: Image.network(
                provKader.item!.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: 80,
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  provKader.item!.nama,
                  style: PrimaryTextStyle.judulStyle,
                ),
                Text(provKader.item!.jabatan),
              ],
            ),
          ),
          widgetButtonFungsi(provKader, context, gambarKader, posisiKader,
              mediaquery, formKey),
        ],
      ),
    );
  }

  Padding widgetButtonFungsi(
      KaderProvider provKader,
      BuildContext context,
      String gambarKader,
      String posisiKader,
      MediaQueryData mediaquery,
      GlobalKey<FormState> formKey) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: SizedBox(
        height: 100,
        width: 100,
        child: GestureDetector(
          onTap: () {
            log("aksi ?");
            onTapped = true;
            setState(() {});
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              onTapped == true
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            log("Mengahpus ?");
                            onTapped = false;
                            onTapStatusHapus = true;
                            log('Hapus is ${onTapStatusHapus.toString()}');
                            final snackBar = SnackBar(
                              content:
                                  Text('Hapus data ${(provKader.item!.nama)}'),
                              showCloseIcon: true,
                              duration: Duration(seconds: 10),
                              closeIconColor: Colors.white,
                              action: SnackBarAction(
                                label: 'Yes',
                                onPressed: () {
                                  onTapped = true;
                                  setState(() {
                                    provKader
                                        .deleteDataKader(provKader.item!.docId);
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: Text(
                            "Hapus",
                            style: TextStyle(
                                fontSize: 14, color: AppTheme.primaryColor),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            log("Mengedit ?");
                            onTapped = false;
                            onTapStatusEdit = true;
                            log('Edit is ${onTapStatusEdit.toString()}');

                            namaController.text = provKader.item!.nama;
                            alamatController.text = provKader.item!.alamat;
                            gambarKader = "";
                            posisiKader = provKader.item!.jabatan;
                            showDialog(
                              context: context,
                              barrierDismissible:
                                  false, // user must tap button!
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
                                  insetPadding: EdgeInsets.all(12),
                                  content: SingleChildScrollView(
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
                                          'Edit Data Kader Posyandu',
                                          style: TextStyle(
                                              color: Colors.grey[
                                                  600], // Set the text color.
                                              fontSize: 16 // Set the text size.
                                              ),
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          // height: 600,
                                          padding: EdgeInsets.only(
                                              top: 12, left: 20, right: 20),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.40,
                                              child: Form(
                                                key: formKey,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    SizedBox(
                                                      height: 40,
                                                      child: TextFormField(
                                                        autofocus: true,
                                                        controller:
                                                            namaController,
                                                        onChanged: (value) {
                                                          value;
                                                        },
                                                        validator: (value) {},
                                                        obscureText: false,
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText:
                                                              'Nama Kader',
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    SizedBox(
                                                      height: 40,
                                                      child: TextFormField(
                                                        controller:
                                                            alamatController,
                                                        validator: (value) {},
                                                        onChanged: (value) {
                                                          value;
                                                        },
                                                        obscureText: false,
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText: 'Alamat',
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    SizedBox(
                                                      // width: 400,
                                                      height: 40,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                              decoration: BoxDecoration(
                                                                  color: AppTheme
                                                                      .primaryColor
                                                                      .withOpacity(
                                                                          0.2),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12)),
                                                              height: 40,
                                                              width: 40,
                                                              child: Consumer<
                                                                  KaderProvider>(
                                                                builder: (context,
                                                                        proviKader,
                                                                        child) =>
                                                                    Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    if (proviKader
                                                                            .gambarKaderUpdate ==
                                                                        "")
                                                                      SizedBox(
                                                                        height:
                                                                            40,
                                                                        child: Image
                                                                            .network(
                                                                          provKader
                                                                              .item!
                                                                              .image,
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      )
                                                                    else if (proviKader
                                                                            .gambarKaderUpdate !=
                                                                        proviKader
                                                                            .item!
                                                                            .image)
                                                                      SizedBox(
                                                                        height:
                                                                            40,
                                                                        child: Image
                                                                            .network(
                                                                          proviKader
                                                                              .gambarKaderUpdate,
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      )
                                                                    else
                                                                      SizedBox(
                                                                        height:
                                                                            40,
                                                                        child: Image
                                                                            .network(
                                                                          proviKader
                                                                              .item!
                                                                              .image,
                                                                          fit: BoxFit
                                                                              .contain,
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

                                                              provKader
                                                                  .updatepickImage();
                                                              log("dan image terupdate");
                                                              setState(() {
                                                                gambarKader ==
                                                                    provKader
                                                                        .gambarKader;
                                                              });
                                                              print("Updated");
                                                            },
                                                            child: SizedBox(
                                                              width: 200,
                                                              height: 40,
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    gambarController,
                                                                enabled: false,
                                                                validator:
                                                                    (value) {},
                                                                obscureText:
                                                                    false,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                  // logika kalo terpilih image nya ganti text ke TERPILIH
                                                                  labelText: gambarKader ==
                                                                          ''
                                                                      ? "image Terpilih"
                                                                      : "pilih image",
                                                                  labelStyle:
                                                                      TextStyle(
                                                                          color:
                                                                              Colors.green),
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
                                                      keyboardType:
                                                          TextInputType.number,
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .always,
                                                      clearIconProperty:
                                                          IconProperty(
                                                              color:
                                                                  Colors.green),
                                                      searchDecoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  "enter your custom hint text here"),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return "Posisi Perlu Diisi";
                                                        } else {
                                                          provKader
                                                                  .posisiKader =
                                                              value;

                                                          // return null;
                                                        }
                                                      },
                                                      dropDownList: const [
                                                        DropDownValueModel(
                                                            name:
                                                                'ketua Posyandu',
                                                            value: "Ketua"),
                                                        DropDownValueModel(
                                                            name: 'Anggota',
                                                            value: "Anggota")
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary: AppTheme
                                                                  .primaryColor),
                                                      onPressed: () {
                                                        String id = DateTime
                                                                .now()
                                                            .millisecondsSinceEpoch
                                                            .toString();
                                                        provKader
                                                            .updateDataKader(DataKaderModels(
                                                                docId: provKader
                                                                    .item!.docId,
                                                                nama: namaController
                                                                    .text,
                                                                alamat:
                                                                    alamatController
                                                                        .text,
                                                                verfiedAt:
                                                                    false,
                                                                jabatan: provKader
                                                                    .posisiKader,
                                                                image: provKader
                                                                            .gambarKaderUpdate ==
                                                                        ""
                                                                    ? provKader
                                                                        .item!
                                                                        .image
                                                                    : provKader
                                                                        .gambarKaderUpdate))
                                                            .whenComplete(() {
                                                          Navigator.pop(
                                                              context);
                                                          final snackBar =
                                                              SnackBar(
                                                            content: Text(
                                                                'Sukses Update Data'),
                                                            duration: Duration(
                                                                seconds: 4),
                                                          );

                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                          setState(() {
                                                            namaController
                                                                .clear();
                                                            alamatController
                                                                .clear();
                                                            jabatanController
                                                                .clear();
                                                            provKader
                                                                .gambarKaderUpdate = '';
                                                            gambarKader = '';
                                                            provKader
                                                                .posisiKader = '';
                                                          });
                                                        });
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          "Update Data Kader",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
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
                                      ]),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            "Update",
                            style: TextStyle(
                                fontSize: 14, color: AppTheme.primaryColor),
                          ),
                        ),
                      ],
                    )
                  : GestureDetector(
                      onTap: () {
                        log("aksi ?");
                        onTapped = true;
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.more_horiz,
                        size: 24,
                        color: Color.fromARGB(255, 69, 69, 69),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Container statusDetail(MediaQueryData mediaquery, provKader) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(color: Color.fromARGB(255, 239, 238, 238)),
      padding: EdgeInsets.only(top: 20, left: 12),
      height: 80,
      width: mediaquery.size.width * 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(IconlyBroken.lock),
          SizedBox(
            width: 240,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Verfied Status",
                  style: PrimaryTextStyle.judulStyle,
                ),
                provKader.item.verfiedAt == false
                    ? const Text(
                        "Pending",
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      )
                    : const Text(
                        "Aktif (Verified)",
                        style: TextStyle(color: Colors.green, fontSize: 14),
                      ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
            child: Row(
              children: const [
                Icon(
                  Icons.circle,
                  size: 5,
                  color: Color.fromARGB(255, 69, 69, 69),
                ),
                Icon(
                  Icons.circle,
                  size: 5,
                  color: Color.fromARGB(255, 69, 69, 69),
                ),
                Icon(
                  Icons.circle,
                  size: 5,
                  color: Color.fromARGB(255, 69, 69, 69),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container alamatDetail(MediaQueryData mediaquery, provKader) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(color: Color.fromARGB(255, 239, 238, 238)),
      padding: EdgeInsets.only(top: 20, left: 12),
      height: 80,
      width: mediaquery.size.width * 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(IconlyBroken.home),
          SizedBox(
            width: 240,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Alamat/rumah",
                  style: PrimaryTextStyle.judulStyle,
                ),
                Text(
                  provKader.item.alamat,
                  style: PrimaryTextStyle.subTxt,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
            child: Row(
              children: const [
                Icon(
                  Icons.circle,
                  size: 5,
                  color: Color.fromARGB(255, 69, 69, 69),
                ),
                Icon(
                  Icons.circle,
                  size: 5,
                  color: Color.fromARGB(255, 69, 69, 69),
                ),
                Icon(
                  Icons.circle,
                  size: 5,
                  color: Color.fromARGB(255, 69, 69, 69),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container posisiDetail(MediaQueryData mediaquery, provKader) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(color: Color.fromARGB(255, 239, 238, 238)),
      padding: EdgeInsets.only(top: 20, left: 12),
      height: 80,
      width: mediaquery.size.width * 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(IconlyBroken.info_circle),
          SizedBox(
            width: 240,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Posisi/Jabatan",
                  style: PrimaryTextStyle.judulStyle,
                ),
                Text(
                  provKader.item.jabatan,
                  style: PrimaryTextStyle.subTxt,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
            child: Row(
              children: const [
                Icon(
                  Icons.circle,
                  size: 5,
                  color: Color.fromARGB(255, 69, 69, 69),
                ),
                Icon(
                  Icons.circle,
                  size: 5,
                  color: Color.fromARGB(255, 69, 69, 69),
                ),
                Icon(
                  Icons.circle,
                  size: 5,
                  color: Color.fromARGB(255, 69, 69, 69),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

// edit bottomsheet
}
