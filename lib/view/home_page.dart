import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:posyandu_care_apps/themes/colors.dart';
import 'package:posyandu_care_apps/view/dashboard_page.dart';
import 'package:posyandu_care_apps/view/detail_screen/artikel_kesehatan.dart';
import 'package:posyandu_care_apps/view/detail_screen/kader.dart';
import 'package:posyandu_care_apps/view/detail_screen/kunjungan.dart';
import 'package:posyandu_care_apps/view/detail_screen/upt_page.dart';

import '../models/list_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int initialPage = 0;
  late PageController bottomNavigationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bottomNavigationController = PageController(initialPage: initialPage);
  }

  updateIndexPage(page) {
    setState(() {
      initialPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        body: PageView(
          controller: bottomNavigationController,
          children: [
            const DashboardPage(),
            Kunjungan(index: 0),
            KaderPage(index: 1),
            // UptPage(index: 1),
            ArtikelKesehatan()
          ],
          onPageChanged: updateIndexPage,
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              canvasColor: AppTheme.primaryColor,
              primaryColor: Colors.red,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: new TextStyle(color: Colors.yellow))),
          child: BottomNavigationBar(
            currentIndex: initialPage,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(IconlyBroken.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(IconlyBroken.user_2),
                label: "Kunjungan",
                activeIcon: Icon(IconlyBroken.user_3),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_hospital_sharp),
                label: "Kaders",
                activeIcon: Icon(Icons.local_hospital_sharp),
              ),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.local_hospital_outlined),
              //     label: "UPT",
              //     activeIcon: Icon(Icons.local_hospital_sharp)),
              BottomNavigationBarItem(
                  icon: Icon(IconlyBroken.paper_fail), label: "Artikel")
            ],
            onTap: (page) {
              bottomNavigationController.animateToPage(page,
                  duration: Duration(microseconds: 400), curve: Curves.ease);
            },
          ),
        ));
  }
}
