import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/blog.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Blog> posts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    final String apiUrl = "https://intent-kit-16.hasura.app/api/rest/blogs";
    final String adminSecret =
        "32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6";

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'x-hasura-admin-secret': adminSecret},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> data = responseData['blogs'];

        setState(() {
          posts.addAll(data.map((item) => Blog(
                id: item['id'],
                imageUrl: item['image_url'],
                title: item['title'],
                isFav: false,
              )));
          isLoading = false; // Data has been loaded
        });
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (error) {
      print(error);
      // Handle error here
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var hi = MediaQuery.of(context).size.height;
    var wi = MediaQuery.of(context).size.width;
    return MaterialApp(
      color: Colors.white,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 60, left: 25),
                        height: 140,
                        width: wi,
                        color: Color.fromARGB(255, 1, 18, 23),
                        child: Text(
                          'Blogs',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                      Positioned(
                        top:
                            110, // Position the second container 150 pixels from the top

                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                          ),
                          height: 50,
                          width: wi,
                          child: Center(child: Text(' ')),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: hi * 0.15,
                  ),
                  // Container(height: 8000, child: PostList()),
                  isLoading
                      ? Center(
                          child:
                              CircularProgressIndicator(), // Show loading spinner
                        )
                      : Container(
                          height: posts.length * 260,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(posts[index].id),
                                subtitle: Text(posts[index].imageUrl),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
