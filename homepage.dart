import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'customtext.dart';
import 'main.dart';

void main() {
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      home: NewsScreen(),
    );
  }
}

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<dynamic> articles = [];
  bool _isLoading = true;
  List<bool> cardExpanded = [];

  Future<void> _refresh() async {
    setState(() {
      fetchNews();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=tesla&from=2023-07-17&sortBy=publishedAt&apiKey=f9da3552b7074373878ffd0878f06c55'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey('articles') && data['articles'] is List) {
        setState(() {
          _isLoading = false;
          articles = List<dynamic>.from(data['articles']);
          cardExpanded = List.generate(articles.length, (index) => false);
        });
      }
    } else {
      print('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        title: CustomText(
          sTextToDisplay: 'News App',
          dTextSize: 26,
          bMakeBold: true,
          colorOfText: Colors.white,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: _isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : articles.isEmpty
            ? Center(
          child: Text(
            'Your Related Routes details is empty for this Task.',
            textAlign: TextAlign.center,
          ),
        )
            : ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return news(index);
          },
        ),
      ),
      backgroundColor: Colors.black,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black38,
              ),
              child: Container(
                color: Colors.black38, // Background color
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/news.jpg', // Replace with your image path
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            Container(
              color: Colors.black38,
              child: ListTile(
                title: CustomText(
                  sTextToDisplay: 'Logout',
                  dTextSize: 18,
                  bMakeBold: true,
                  colorOfText: Colors.white, // Change text color to white
                ),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginApp()),
                  );
                },
              ),
            ),

          ],
        ),
      ),

    );
  }

  Widget news(int index) {
  if (articles.isEmpty) {
  return Container(
  child: Text('Error'),
  );
  } else {
  var article = articles[index];

  String title = article['source']['name'];
  String description = article['description'];
  String publishedAt = article['publishedAt'];
  DateTime dateTime = DateTime.parse(publishedAt);

  String formattedTime = DateFormat('HH:mm').format(dateTime);

  return InkWell(
  onTap: () {
  setState(() {
  cardExpanded[index] = !cardExpanded[index];
  });
  },
  child: Card(
  shadowColor: Colors.black,
  elevation: 10,
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10),
  ),
  child: Container(
  color: Colors.black87,
  padding: EdgeInsets.all(10),
  child: Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Expanded(
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  if (cardExpanded[index])
  Image.network(
  article['urlToImage'] ??
  'https://thepointsguy.global.ssl.fastly.net/us/originals/2022/04/GettyImages-1355168441-scaled.jpg',
  width: double.infinity,
  height: 200,
  fit: BoxFit.cover,
  ),
  CustomText(
  sTextToDisplay: title,
  dTextSize: 16,
  bMakeBold: true,
  colorOfText: Colors.white,
  ),
  if (!cardExpanded[index])
  SizedBox(height: 5),
  if (!cardExpanded[index])
  CustomText(
  sTextToDisplay: description,
  dTextSize: 14,
  bMakeBold: false,
  maxLines: 5,
  colorOfText: Colors.white,
  ),
  SizedBox(height: 5),
    Row(
      children: [
        CustomText(
          sTextToDisplay: '$formattedTime PM IST',
          dTextSize: 16,
          bMakeBold: true,
          colorOfText: Colors.white,
        ),
        SizedBox(width: 140),
        Icon(
          cardExpanded[index]
              ? Icons.more_vert_outlined
              : Icons.more_horiz,
          color: Colors.white,
          size: 24,
        ),
      ],
    ),

  ],
  ),
  ),
  if (!cardExpanded[index])
  Image.network(
  article['urlToImage'] ??
  'https://thepointsguy.global.ssl.fastly.net/us/originals/2022/04/GettyImages-1355168441-scaled.jpg',
  width: 80,
  height: 100,
  fit: BoxFit.cover,
  ),
  SizedBox(width: 10), // Spacing between text and image/icon

  ],
  ),
  ),
  ),
  );
  }
  }
}






