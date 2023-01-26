import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_record/components/controller/user_controller.dart';
import 'package:money_record/config/app_asset.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      const Text('Hi,'),
                      Builder(
                        builder: (context) {
                          return Text(userController.data.name ?? '');
                        },
                      ),
                    ],
                  ),
                ),
                const Material(
                  child: InkWell(
                    child: Icon(Icons.menu),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
