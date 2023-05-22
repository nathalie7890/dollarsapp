import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ui
import "../colors.dart";
import '../widgets/nunito_text.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";

// utils
import '../utils/utils.dart';

// repo
import 'package:dollar_app/service/auth_service.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final auth = AuthService();

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

// set username
  String _username = "";
  String _photoUrl = "";

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

  _goToTransaction() {
    context.push("/transaction");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: bg,
      child: Column(
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
            child: _transactionList(),
          )
        ],
      ),
    );
  }

// recent transaction list
  ListView _transactionList() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _goToTransaction(),
          child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: primary,
                    child: Icon(
                      FontAwesomeIcons.utensils,
                      color: tertiary,
                      size: 20.0,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      nunitoText(
                          "Hoshino Omakase", 15, FontWeight.w800, primary),
                      nunitoText("14/10/2023", 13, FontWeight.w500, primary)
                    ],
                  ),
                  const Spacer(),
                  nunitoText("RM4.50", 15, FontWeight.w700, primary)
                ],
              )),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 15);
      },
      itemCount: 10,
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
              child: _moneyCard("Income", "RM 341, 972"),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: _moneyCard("Expense", "RM 67, 108"),
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
          nunitoText(value, 20, FontWeight.w500, primary),
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
                      "assets/images/logo.jpg",
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
