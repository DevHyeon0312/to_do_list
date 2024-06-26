import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/feature/main/controller/main_tab_controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainTabController tabController = Get.put(MainTabController());

  final List<Widget> pages = [
    Container(
      child: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
          );
        },
      ),
    ),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: tabController.selectedIndex,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: tabController.selectedIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.task_outlined),
              label: '할일',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: '진행중',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.task_alt_outlined),
              label: '완료',
            ),
          ],
          onTap: (int index) {
            tabController.onItemTapped(index);
          },
        ),
      ),
    );
  }
}
