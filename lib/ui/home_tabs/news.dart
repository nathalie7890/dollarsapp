import 'dart:convert';

import 'package:dollar_app/ui/colors.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/loading.dart';
import 'package:dollar_app/ui/widgets/horizontal_divider.dart';
import 'package:dollar_app/ui/widgets/nunito_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<dynamic>? _news;
  bool _isLoading = true;

  Future<List<dynamic>?> fetchNewsData() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=5b90c5912c5e412c80f27d1b8b96a88e'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['articles'];
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _controller.repeat();
    _fetchNews();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future _fetchNews() async {
    final res = await fetchNewsData();
    if (res != null) {
      setState(() {
        _news = res;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? loadingSpinner(_controller)
          : !_isLoading && _news == null || _news != null && _news!.isEmpty
              ? nunitoText("Failed to fetch news", 20, FontWeight.w600, primary)
              : Container(
                  color: bg,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      nunitoText("Articles", 25, FontWeight.bold, primary),
                      nunitoText(
                          "Find articles that might help you plan your budget better!",
                          16,
                          FontWeight.w500,
                          Colors.grey.shade600),
                      divider(color: Colors.grey.shade600),
                      Expanded(
                        child: MasonryGridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          itemCount: _news?.length,
                          itemBuilder: (context, index) {
                            final article = _news?[index];
                            return gridTile(article);
                          },
                        ),
                      ),
                    ],
                  )),
    );
  }

  Container gridTile(dynamic article) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: article['urlToImage'] != null
                  ? Image.network(article['urlToImage'])
                  : Image.asset("assets/images/bob_marley.jpg")),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      article['title'].split(" ").first,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: primary),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_circle_right,
                          color: primary,
                        ))
                  ],
                ),
                const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                  style: TextStyle(
                      fontSize: 12, color: Color.fromRGBO(133, 133, 133, 1)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
