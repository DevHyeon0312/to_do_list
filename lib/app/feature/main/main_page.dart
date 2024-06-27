import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/app/feature/main/controller/main_tab_controller.dart';
import 'package:to_do_list/app/feature/task/page/task_complete_list_page.dart';
import 'package:to_do_list/app/feature/task/page/task_ongoing_list_page.dart';
import 'package:to_do_list/app/feature/task/page/task_pending_list_page.dart';

///
/// [MainPage] main page
/// * [TaskPendingPage] 할일 페이지
/// * [TaskOngoingListPage] 진행중 페이지
/// * [TaskCompleteListPage] 완료 페이지
///
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainTabController tabController = Get.put(MainTabController());

  final List<Widget> pages = const [
    TaskPendingPage(),
    TaskOngoingListPage(),
    TaskCompleteListPage(),
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
