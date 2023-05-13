import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posyandu_care_apps/themes/style.dart';
import 'package:posyandu_care_apps/view/kunjungan_page/kunjungan_detail.dart';
import 'package:posyandu_care_apps/view/login/login_page.dart';
import 'package:posyandu_care_apps/widget/artikel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';
import '../models/list_menu.dart';
import '../view_model/artikel_provider.dart';
import 'artikel_page/artikel_kesehatan.dart';
import 'kaders_page/kader.dart';
import 'kunjungan_page/kunjungan.dart';
import 'upt_page/upt_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DateTime _selectedDay = DateTime.now();
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<ArtikelProvider>(context, listen: false)
          .fetchDataArtikel(),
    );
    getEmail();
  }

  Future logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();

    sharedPreferences.remove('email');
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  String role = '';
  Future getEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      role = sharedPreferences.getString('email')!;
    });
    print('isemail :{$role}');
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SafeArea(
          // before is sizebox, tapi listview nya beda2 ketika beda device antara SM & lain
          // height: mediaquery.size.height * 5,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widgetHeader(context, role),
              listMenu(context),
              const SizedBox(
                height: 10,
              ),
              listBacaWidget(mediaquery)
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetHeader(BuildContext context, role) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      height: 300,
      decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Hello, ",
                    style: PrimaryTextStyle.secondStyle,
                  ),
                  Text(
                    role == "posyandu@mail.com"
                        ? "Posyandu Cempaka Mulya"
                        : "Puskesmas Dukupuntang",
                    style: PrimaryTextStyle.primaryStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // seach bar
                ],
              ),
              GestureDetector(
                onTap: () {
                  log("Logout");
                  logout();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: 50,
                    height: 50,
                    // color: const Color.fromARGB(255, 250, 250, 250),
                    child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJXzbvzNK4gdppYD-rqrs1j4flRxmt3b8UCg&usqp=CAU",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
              width: 400,
              height: 40,
              alignment: Alignment.center,
              child: TextFormField(
                initialValue: "Cari data",
                decoration: InputDecoration(
                  // fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintText: "Search",

                  enabledBorder: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide:
                          const BorderSide(width: 2, color: Colors.white)),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          WeeklyDatePicker(
            backgroundColor: AppTheme.primaryColor,
            weekdays: const [
              'Mon',
              'Tue',
              'Wed',
              'Thu',
              'Fri',
              'Sat',
              'Sun',
            ],
            selectedBackgroundColor: Colors.white,
            enableWeeknumberText: false,
            selectedDigitColor: AppTheme.primaryColor,
            digitsColor: Colors.white,
            weekdayTextColor: Colors.white,
            selectedDay: _selectedDay, // DateTime
            changeDay: (value) => setState(() {
              _selectedDay = value;
            }),
          )
        ],
      ),
    );
  }

  Widget listMenu(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
          child: Text(
            "Services",
            style: PrimaryTextStyle.judulStyle,
          ),
        ),
        SizedBox(
          height: 150,
          child: ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: menu.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor.withOpacity(0.10),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              log('Tapped ${menu[index]['judul'].toString()}');
                              if (index == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Kunjungan(
                                          index: index,
                                        )));
                              } else if (index == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => KaderPage(
                                          index: index,
                                        )));
                              } else if (index == 2) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UptPage(
                                          index: index,
                                        )));
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                menu[index]['icons'],
                                size: 40,
                                weight: 2.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        menu[index]['judul'],
                      )
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }

  listBacaWidget(mediaQuery) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Baca Kesehatan",
                style: PrimaryTextStyle.judulStyle,
              ),
              GestureDetector(
                onTap: () {
                  log("Ke halaman artikel kesehatan");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ArtikelKesehatan()));
                },
                child: Text("More", style: PrimaryTextStyle.judulStyle),
              ),
            ],
          ),
        ),
        Consumer<ArtikelProvider>(
          builder: ((context, providerArtikel, child) {
            if (providerArtikel.requestState == RequestState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (providerArtikel.requestState == RequestState.loaded) {
              final item = providerArtikel.dataArtikelFetched;
              return SizedBox(
                height: 250,
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: providerArtikel.dataArtikelFetched.length < 3
                      ? providerArtikel.dataArtikelFetched.length
                      : 3,
                  itemBuilder: (context, index) {
                    final artikel = item[index];
                    return ArtikelWiget(artikel: artikel);
                  },
                ),
              );
            }
            if (providerArtikel.requestState == RequestState.error) {
              return const Center(
                  child:
                      Text("Gagal Mengambil Data, Periksa Akses Internet Mu"));
            } else {
              return const Text("tidak diketahui");
            }
          }),
        ),
      ],
    );
  }
}
