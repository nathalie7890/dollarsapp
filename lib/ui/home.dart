import 'package:dollar_app/ui/home_tabs/expenses.dart';
import 'package:dollar_app/ui/home_tabs/income.dart';
import 'package:flutter/cupertino.dart';
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
          appBar: AppBar(
            backgroundColor: bg,
            elevation: 0,
          ),
          body: const TabBarView(children: [
            Expenses(),
            Income(),
            SizedBox(),
            Expenses(),
            Income()
          ]),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
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
                labelColor: Colors.black87,
                indicatorColor: Colors.transparent,
                // indicator: BoxDecoration(
                //     shape: BoxShape.circle, color: Colors.transparent),
                tabs: [
                  const Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(CupertinoIcons.house, size: 30),
                    ),
                  ),
                  const Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child:
                          Icon(Icons.account_balance_wallet_outlined, size: 30),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: FloatingActionButton(
                        onPressed: () => {},
                        backgroundColor: Colors.black87,
                        child: const Icon(Icons.add, size: 30),
                      ),
                    ),
                  ),
                  const Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(Icons.credit_card_outlined, size: 30),
                    ),
                  ),
                  const Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(Icons.person_outline_rounded, size: 30),
                    ),
                  ),
                ]),
          ),
        ));
  }
}
