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

class _HomeState extends State<Home> {
  late String tabState;

  @override
  void initState() {
    super.initState();
    tabState = widget.tabState ?? "";
    debugPrint("Home init: $tabState");
  }

  _goToAddTrans() async {
    var res = await context.push("/addTrans");
    if (res != null) {
      setState(() {
        tabState = res.toString();
        debugPrint("Home context: $tabState");
        context.push("/home/$tabState");
      });
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
            child: TabBarView(children: [
              const HomeTab(),
              Transactions(
                tabState: tabState,
              ),
              const SizedBox(),
              const News(),
              const Profile()
            ]),
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
