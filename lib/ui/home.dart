import 'package:dollar_app/ui/home_tabs/homeTab.dart';
import 'package:dollar_app/ui/home_tabs/profile.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/expenses.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/transactions.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter/material.dart';
import "colors.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          // appBar: AppBar(
          //   title: nunitoText("Dollars", 20, FontWeight.bold, primary),
          //   backgroundColor: Colors.grey.shade50,
          //   elevation: 0,
          //   actions: [
          //     IconButton(
          //         onPressed: () => debugPrint("logout"),
          //         icon: const Icon(
          //           Icons.logout,
          //           color: primary,
          //         )),
          //   ],
          // ),
          body: const Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: TabBarView(children: [
              HomeTab(),
              Transactions(),
              SizedBox(),
              Expenses(),
              Profile()
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
                        onPressed: () => {},
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
