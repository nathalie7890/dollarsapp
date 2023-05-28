import 'package:heroicons/heroicons.dart';
import 'package:flutter/material.dart';
import "package:go_router/go_router.dart";
import "colors.dart";

// tabs
import "home_tabs/home_tab.dart";
import 'package:dollar_app/ui/home_tabs/transactions.dart';
import 'package:dollar_app/ui/home_tabs/news.dart';
import 'package:dollar_app/ui/home_tabs/profile.dart';

class Home extends StatefulWidget {
  final String? tabState;

  const Home({Key? key, this.tabState}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late String tabState;
  late TabController _tabController;
  late bool refresh;

  @override
  void initState() {
    super.initState();
    tabState = widget.tabState ?? "";
    _tabController = TabController(
        length: 5, vsync: this, initialIndex: tabState == "" ? 0 : 1);
    refresh = false;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _navigateToTab(int index) {
    setState(() {
      _tabController.animateTo(index);
    });
  }

  _goToAddTrans() async {
    final res = await context.push("/addTrans");
    debugPrint("addTrans res: ${res.toString()}");
    if (res != null) {
      setState(() {
        tabState = res.toString();
        refresh = true;
        context.go("/home/$tabState");
      });
    }
    setState(() {
      refresh = false;
    });
  }

  _scrollTabs(DragEndDetails details) {
    if (details.primaryVelocity! < 0) {
      if (_tabController.index == 0) {
        _navigateToTab(1);
      } else if (_tabController.index == 1) {
        _navigateToTab(3);
      } else if (_tabController.index == 3) {
        _navigateToTab(4);
      }
    } else if (details.primaryVelocity! > 0) {
      if (_tabController.index == 4) {
        _navigateToTab(3);
      } else if (_tabController.index == 3) {
        _navigateToTab(1);
      } else if (_tabController.index == 1) {
        _navigateToTab(0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        initialIndex: tabState == "" ? 0 : 1,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: GestureDetector(
              onHorizontalDragEnd: (details) => _scrollTabs(details),
              child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const HomeTab(),
                    Transactions(
                      tabState: tabState,
                      refresh: refresh,
                    ),
                    const SizedBox(),
                    const News(),
                    const Profile()
                  ]),
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                  spreadRadius: 5,
                )
              ],
            ),
            child: TabBar(
                controller: _tabController,
                padding: const EdgeInsets.symmetric(vertical: 10),
                unselectedLabelColor: Colors.grey.shade500,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: const EdgeInsets.symmetric(vertical: -2),
                labelColor: primary,
                indicatorColor: Colors.transparent,
                tabs: [
                  const Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: HeroIcon(
                        HeroIcons.home,
                        size: 27,
                      ),
                    ),
                  ),
                  const Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: HeroIcon(
                        HeroIcons.wallet,
                        size: 27,
                      ),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: FloatingActionButton(
                        onPressed: () => {_goToAddTrans()},
                        elevation: 0,
                        backgroundColor: primary,
                        child: const HeroIcon(HeroIcons.plus),
                      ),
                    ),
                  ),
                  const Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: HeroIcon(HeroIcons.newspaper, size: 27),
                    ),
                  ),
                  const Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: HeroIcon(HeroIcons.userCircle, size: 27),
                    ),
                  ),
                ]),
          ),
        ));
  }
}
