import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:posyandu_care_apps/themes/colors.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

import '../models/list_menu.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DateTime _selectedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: mediaquery.size.height * 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widgetHeader(context),
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

  Widget widgetHeader(BuildContext context) {
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
                    "Posyandu Cempaka Mulya",
                    style: PrimaryTextStyle.primaryStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // seach bar
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 50,
                  height: 50,
                  color: const Color.fromARGB(255, 250, 250, 250),
                  // child: Image.network(
                  //   "https://wiki.d-addicts.com/images/thumb/0/0f/NamJiHyun.jpg/300px-NamJiHyun.jpg",
                  //   fit: BoxFit.contain,
                  // ),
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
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Services",
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
                ],
              )
            ],
          ),
        ),
        SizedBox(
          // width: 400,
          height: 150,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: menu.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
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
                              // log('Tapped ${menu[index]['judul'].toString()}');
                              // if (index == 0) {
                              //   Navigator.of(context).push(MaterialPageRoute(
                              //       builder: (context) => Kunjungan(
                              //             index: index,
                              //           )));
                              // } else if (index == 1) {
                              //   log("  peralatan posyandu");
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => Kunjungan(
                              //           index: index,
                              //         )));
                              // }
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
              Text(
                "More",
                style: PrimaryTextStyle.judulStyle,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 20),
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            itemCount: listBerita.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
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
                                listBerita[index]["judulBerita"],
                                style: PrimaryTextStyle.judulStyle,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  listBerita[index]["tanggal"],
                                  style: PrimaryTextStyle.subTxt,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(
                                  Icons.circle,
                                  size: 5,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  listBerita[index]["waktu_pub"],
                                  style: PrimaryTextStyle.subTxt,
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
                                Text(
                                  "Read more for read",
                                  style:
                                      TextStyle(color: AppTheme.primaryColor),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12)),
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(IconlyBroken.hide),
                                Text("no previews")
                              ],
                            )
                            // Image.asset(
                            //   listBerita[index]["gambar"].toString(),
                            //   fit: BoxFit.contain,
                            // )
                            )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
