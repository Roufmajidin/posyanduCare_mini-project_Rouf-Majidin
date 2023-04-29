import 'dart:developer';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:posyandu_care_apps/models/list_menu.dart';

import '../../themes/colors.dart';

class KaderDetail extends StatefulWidget {
  final index;
  KaderDetail({super.key, required this.index});
  var formKey = GlobalKey<FormState>();

  @override
  State<KaderDetail> createState() => _KaderDetailState();
}

class _KaderDetailState extends State<KaderDetail> {
  var onTapped = false;
  var onTapStatusEdit = false;
  var onTapStatusHapus = false;
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: AppTheme.primaryColor,
          title: Text("Detail Kader"),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(IconlyBroken.info_circle),
            )
          ],
        ),
      ),
      backgroundColor: AppTheme.bgColor,
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          profileDetail(mediaquery),
          posisiDetail(mediaquery),
          alamatDetail(mediaquery),
        ],
      )),
    );
  }

  Container alamatDetail(MediaQueryData mediaquery) {
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
                  "Blok Gunung, Rt 001/002",
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

  Container posisiDetail(MediaQueryData mediaquery) {
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
                  kader[widget.index]['posisiJabatan'],
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

  Container profileDetail(MediaQueryData mediaquery) {
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
                // child: Image.network(
                //   "https://wiki.d-addicts.com/images/thumb/0/0f/NamJiHyun.jpg/300px-NamJiHyun.jpg",
                //   fit: BoxFit.contain,
                // ),
              ),
            ),
            SizedBox(
              height: 70,
              width: onTapped == false ? 200 : 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    kader[widget.index]['namaKader'],
                  ),
                  Text(kader[widget.index]['posisiJabatan']),
                ],
              ),
            ),
            onTapped == true
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () {
                              log("Mengahpus ?");
                              onTapped = false;
                              onTapStatusHapus = true;
                              log('Hapus is ${onTapStatusHapus.toString()}');
                              final snackBar = SnackBar(
                                content: Text(
                                    'Hapus is ${onTapStatusHapus.toString()}'),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    onTapped = true;
                                    setState(() {});
                                  },
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              setState(() {});
                            },
                            child: Text("Hapus")),
                        SizedBox(
                          height: 30,
                          child: GestureDetector(
                              onTap: () {
                                log("Mengedit ?");
                                onTapped = false;
                                onTapStatusEdit = true;
                                log('Edit is ${onTapStatusEdit.toString()}');
                                updateKader(context, widget.index, mediaquery,
                                    widget.formKey);
                              },
                              child: const Text("Edit")),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 80,
                      child: GestureDetector(
                        onTap: () {
                          log("aksi ?");
                          onTapped = true;
                          setState(() {});
                        },
                        child: SizedBox(
                          height: 80,
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
                        ),
                      ),
                    ),
                  ),
          ],
        ));
  }

// edit bottomsheet
  Future<dynamic> updateKader(BuildContext context, index, mediaQ, formKey) {
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
                          onPressed: () {
                            Navigator.pop(context);
                            final snackBar = SnackBar(
                              content: Text('Sukses Edit'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  onTapped = true;
                                  setState(() {});
                                },
                              ),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            setState(() {});
                          },
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
