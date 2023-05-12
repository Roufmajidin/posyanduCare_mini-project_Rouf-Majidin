import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:posyandu_care_apps/view_model/upt_provider.dart';
import 'package:provider/provider.dart';

import '../../../themes/style.dart';

class UptPage extends StatefulWidget {
  final index;
  UptPage({super.key, required this.index});
  var formKey = GlobalKey<FormState>();

  @override
  State<UptPage> createState() => _UptPageState();
}

class _UptPageState extends State<UptPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<UptProvider>(context, listen: false).fetchDataUpt());
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(
              elevation: 0.3,
              backgroundColor: AppTheme.primaryColor,
              title: const Text(
                "Data UPT",
                style: TextStyle(fontSize: 16),
              ),
              centerTitle: true,
              actions: const [
                Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(IconlyBroken.info_square))
              ])),
      backgroundColor: AppTheme.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Consumer<UptProvider>(builder: (context, uptProvider, _) {
            if (uptProvider.requestState == RequestState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (uptProvider.requestState == RequestState.loaded) {
              return Expanded(
                  child: SingleChildScrollView(
                      child: Container(
                          padding: EdgeInsets.only(bottom: 50),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              profileUpt(uptProvider),
                              detailUpt(mediaquery, uptProvider),
                              keteranganWidget(mediaquery, uptProvider),
                              dokterTugasWidget(mediaquery, uptProvider),
                            ],
                          ))));
            }
            if (uptProvider.requestState == RequestState.error) {
              return const Center(
                  child:
                      Text("Gagal Mengambil Data, Periksa Akses Internet Mu"));
            } else {
              return const Text("tidak diketahui");
            }
          })
        ],
      ),
    );
  }

  keteranganWidget(MediaQueryData mediaquery, uptProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Keterangan",
              style: PrimaryTextStyle.judulStyle,
            )),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 239, 238, 238),
                borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.only(top: 12, left: 12),
            height: 150,
            width: mediaquery.size.width * 1,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 240,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 6.0),
                                child: Icon(
                                  IconlyBroken.edit,
                                  size: 18,
                                ),
                              ),
                              Text(
                                "Titik Posyandu",
                                style: PrimaryTextStyle.thirdStyle,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            uptProvider.itemPuskemas!.nama ?? false,
                            style: PrimaryTextStyle.subTxt,
                          ),
                          Row(
                            children: [
                              Text(
                                "Desa : ",
                                style: PrimaryTextStyle.subTxt,
                              ),
                              Text(
                                uptProvider.itemPuskemas!.desa ?? false,
                                style: PrimaryTextStyle.subTxt,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  dokterTugasWidget(MediaQueryData mediaquery, uptProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Dokter Tugas",
            style: PrimaryTextStyle.judulStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 239, 238, 238),
                borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.only(
              top: 12,
              left: 12,
            ),
            height: 80,
            width: mediaquery.size.width * 1,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 290,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 6.0),
                                child: Icon(
                                  IconlyBroken.user_2,
                                  size: 18,
                                ),
                              ),
                              Text(
                                "Dokter Pembina Posyandu",
                                style: PrimaryTextStyle.thirdStyle,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            uptProvider.itemPuskemas!.dokterPembina ?? false,
                            style: PrimaryTextStyle.subTxt,
                          ),
                          Row(
                            children: [
                              Text(
                                "Titik Posyandu : ",
                                style: PrimaryTextStyle.subTxt,
                              ),
                              Text(
                                uptProvider.itemPuskemas!.nama ?? false,
                                style: PrimaryTextStyle.subTxt,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer()
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  detailUpt(MediaQueryData mediaquery, uptProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Detail UPT",
            style: PrimaryTextStyle.judulStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 239, 238, 238),
                borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.only(
              top: 12,
              left: 12,
            ),
            height: 250,
            width: mediaquery.size.width,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: mediaquery.size.width * 0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 6.0),
                                child: Icon(
                                  IconlyBroken.user_2,
                                  size: 18,
                                ),
                              ),
                              Text(
                                uptProvider.item!.kecamatan ?? false,
                                style: PrimaryTextStyle.thirdStyle,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Alamat",
                                        style: PrimaryTextStyle.subTxt,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Kode Pos",
                                        style: PrimaryTextStyle.subTxt,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Kecamatan",
                                        style: PrimaryTextStyle.subTxt,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Kabupaten",
                                        style: PrimaryTextStyle.subTxt,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "No. Bangunan",
                                        style: PrimaryTextStyle.subTxt,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        ': ${uptProvider.item!.alamat ?? false}',
                                        style: PrimaryTextStyle.subTxt,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        ': ${uptProvider.item!.kodePos ?? false.toString()}',
                                        style: PrimaryTextStyle.subTxt,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        ': ${uptProvider.item!.kecamatan ?? false}',
                                        style: PrimaryTextStyle.subTxt,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        ': ${uptProvider.item!.kabupaten}',
                                        style: PrimaryTextStyle.subTxt,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        ': ${uptProvider.item!.noBangunan}',
                                        style: PrimaryTextStyle.subTxt,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer()
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Padding profileUpt(UptProvider uptProvider) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
              color: const Color.fromARGB(129, 158, 158, 158),
              borderRadius: BorderRadius.circular(20)),
          child: const Icon(
            IconlyBroken.paper_fail,
            color: Colors.white,
            size: 60,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                uptProvider.item!.namaUpt.toString(),
                style: PrimaryTextStyle.judulStyle,
              ),
              Text(uptProvider.item!.kecamatan.toString()),
            ],
          ),
        ),
      ],
    ),
  );
}
