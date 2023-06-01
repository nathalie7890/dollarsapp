import 'dart:convert';

import 'package:dollar_app/ui/colors.dart';
import 'package:dollar_app/ui/widgets/loading.dart';
import 'package:dollar_app/ui/widgets/horizontal_divider.dart';
import 'package:dollar_app/ui/widgets/nunito_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<dynamic>? _news = [];
  bool _isLoading = true;

  Future<List<dynamic>?> fetchNewsData() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=budget&apiKey=5b90c5912c5e412c80f27d1b8b96a88e'));

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

  Future<void> _goToArticle(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
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
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
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
        children: [_articleImage(article), _articleBody(article)],
      ),
    );
  }

  Padding _articleBody(article) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_articleTitle(article), _goToArticleBtn(article)],
          ),
          _articleDesc(article)
        ],
      ),
    );
  }

  Text _articleDesc(article) {
    return Text(
      article['description'],
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
    );
  }

  IconButton _goToArticleBtn(article) {
    return IconButton(
        onPressed: () {
          _goToArticle(Uri.parse(article['url']));
        },
        icon: const Icon(
          Icons.arrow_circle_right,
          color: primary,
        ));
  }

  Flexible _articleTitle(article) {
    return Flexible(
      child: Text(
        article['title'],
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 15, color: primary),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }

  ClipRRect _articleImage(article) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: article['urlToImage'] != null
            ? Image.network(article['urlToImage'])
            : Image.asset("assets/images/no_image.png"));
  }
}
