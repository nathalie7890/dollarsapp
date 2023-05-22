import 'package:dollar_app/ui/colors.dart';
import 'package:dollar_app/ui/widgets/nunito_text.dart';
import 'package:flutter/material.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: nunitoText("News", 20, FontWeight.bold, primary),
    );
  }
}
