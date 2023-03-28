import 'package:d_chart/d_chart.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_record/components/controller/home_controller.dart';
import 'package:money_record/components/controller/user_controller.dart';
import 'package:money_record/config/app_asset.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/config/app_format.dart';
import 'package:money_record/config/session.dart';

import 'auth/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userController = Get.put(UserController());
  final homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    homeController.getAnalysis(userController.data.idUser!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              margin: const EdgeInsets.only(bottom: 0),
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(AppAsset.profile),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () {
                                return Text(
                                  userController.data.name ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                );
                              },
                            ),
                            Obx(
                              () {
                                return Text(
                                  userController.data.email ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Material(
                    color: AppColor.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    child: InkWell(
                      onTap: () => Session.clearUser().then(
                        (value) => Get.off(() => const LoginPage()),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Tambah Transaksi'),
              horizontalTitleGap: 0,
              leading: const Icon(Icons.add),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {},
            ),
            const Divider(height: 1),
            ListTile(
              title: const Text('Pemasukan'),
              horizontalTitleGap: 0,
              leading: const Icon(Icons.north_east),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {},
            ),
            const Divider(height: 1),
            ListTile(
              title: const Text('Pengeluaran'),
              horizontalTitleGap: 0,
              leading: const Icon(Icons.south_east),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {},
            ),
            const Divider(height: 1),
            ListTile(
              title: const Text('Riwayat'),
              horizontalTitleGap: 0,
              leading: const Icon(Icons.history),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
            child: Row(
              children: [
                Image.asset(AppAsset.profile),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hi,',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Obx(
                        () {
                          return Text(
                            userController.data.name ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Builder(
                  builder: (ctx) {
                    return Material(
                      color: AppColor.chartColor,
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          Scaffold.of(ctx).openEndDrawer();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.menu),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              children: [
                Text(
                  'Pengeluaran Hari Ini',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                DView.spaceHeight(),
                cardToday(context),
                DView.spaceHeight(30),
                Center(
                  child: Container(
                    height: 5,
                    width: 80,
                    decoration: BoxDecoration(
                      color: AppColor.backgroundColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                DView.spaceHeight(30),
                Text(
                  'Pengeluaran Minggu Ini',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                DView.spaceHeight(),
                weekly(),
                DView.spaceHeight(30),
                Text(
                  'Perbandingan Bulan Ini',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                DView.spaceHeight(),
                monthly()
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Weekly Chart
  AspectRatio weekly() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: DChartBar(
        data: const [
          {
            'id': 'Bar',
            'data': [
              {'domain': '1000', 'measure': 1},
              {'domain': '2021', 'measure': 4},
              {'domain': '2022', 'measure': 6},
              {'domain': '2023', 'measure': 0.3},
            ],
          },
        ],
        domainLabelPaddingToAxisLine: 8,
        axisLineTick: 2,
        axisLineColor: AppColor.primaryColor,
        measureLabelPaddingToAxisLine: 16,
        barColor: (barData, index, id) => Colors.amber,
        showBarValue: true,
      ),
    );
  }

  // monthly chart

  Row monthly() {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.5,
          child: Stack(
            children: [
              DChartPie(
                data: const [
                  {'domain': 'Flutter', 'measure': 28},
                  {'domain': 'React Native', 'measure': 27},
                  {'domain': 'Ionic', 'measure': 20},
                  {'domain': 'Cordova', 'measure': 15},
                ],
                fillColor: (pieData, index) => Colors.purple,
                donutWidth: 30,
                labelColor: Colors.white,
              ),
              Center(
                child: Text(
                  '60%',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: AppColor.primaryColor,
                      ),
                ),
              ),
            ],
          ),
        ),
        Column(),
      ],
    );
  }

  Material cardToday(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(14),
      elevation: 4,
      color: AppColor.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
            child: Obx(() {
              return Text(
                AppFormat.currency(homeController.today.toString()),
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.secondaryColor,
                    ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
            child: Obx(() {
              return Text(
                homeController.todayPercent,
                style: const TextStyle(
                  color: AppColor.backgroundColor,
                  fontSize: 16,
                ),
              );
            }),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 0, 16),
            padding: const EdgeInsets.symmetric(vertical: 7),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'Selengkapnya',
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 16,
                  ),
                ),
                Icon(Icons.navigate_next),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
