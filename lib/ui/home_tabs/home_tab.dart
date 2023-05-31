import 'package:dollar_app/ui/home_tabs/transactions_tabs/sort.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/emptyList.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/loading.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/trans_list.dart';
import 'package:flutter/material.dart';

// ui
import '../../data/model/trans.dart';
import "../colors.dart";
import '../widgets/nunito_text.dart';

// utils
import '../utils/utils.dart';

// service
import 'package:dollar_app/service/auth_service.dart';
import 'package:dollar_app/service/trans_service.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final auth = AuthService();
  final transService = TransactionService();
  List<Transaction> _trans = [];
  double _totalIncome = 0.0;
  double _totalExpense = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _controller.repeat();
    _getCurrentUser();
    _fetchTrans();
    // _uploadSampleData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

// set username
  String _username = "";
  String _photoUrl = "";

// fetch current user
  _getCurrentUser() {
    final user = auth.getCurrentUser();
    // debugPrint(user.toString());
    if (user != null) {
      setState(() {
        _username = user.displayName ?? "";
        _photoUrl = user.photoURL ?? "";
      });
    }
  }

  // fetch income
  Future _fetchTrans() async {
    final res = await transService.getTransWithType(type: null, category: null);

    if (res != null) {
      setState(() {
        _trans = res;
        _totalIncome = getTotalAmount(_trans, "income", DateTime.now().year);
        _totalExpense = getTotalAmount(_trans, "expense", DateTime.now().year);
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: bg,
      child: _isLoading
          ? loadingSpinner(_controller)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // usernam and profile pic
                _userIntro(),
                const SizedBox(
                  height: 20,
                ),

                // date, income and expense
                _mainCard(),
                const SizedBox(height: 30),

                // recent transaction
                nunitoText("Recent transaction", 20, FontWeight.w600, primary),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: _trans.isEmpty
                      ? emptyList()
                      : transList(context, _trans, true),
                )
              ],
            ),
    );
  }

// main card with date and income and expense
  Container _mainCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                offset: const Offset(0, 5),
                color: Colors.grey.shade800)
          ]),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        nunitoText(Utils.getCurrentDayOfWeek(), 20, FontWeight.w500,
            Colors.grey.shade100),
        nunitoText(Utils.getCurrentDateFormatted(), 15, FontWeight.w500,
            Colors.grey.shade400),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child:
                  _moneyCard("Income", "RM ${_totalIncome.toStringAsFixed(2)}"),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: _moneyCard(
                  "Expense", "RM ${_totalExpense.toStringAsFixed(2)}"),
            )
          ],
        )
      ]),
    );
  }

// small card that displays the amount of income and expense
  Container _moneyCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: tertiary, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          nunitoText(title, 15, FontWeight.w700, primary),
          const SizedBox(
            height: 5,
          ),
          nunitoText(value, 17, FontWeight.w500, primary),
        ],
      ),
    );
  }

// username and user profile pic
  Row _userIntro() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            nunitoText("Hello,", 25, FontWeight.w500, primary),
            nunitoText("@$_username", 25, FontWeight.w800, primary),
          ],
        ),
        SizedBox(
          height: 60,
          child: CircleAvatar(
            radius: 50,
            child: ClipOval(
              child: _photoUrl.isNotEmpty
                  ? Image.network(_photoUrl)
                  : Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
