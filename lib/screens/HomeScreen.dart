import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/blog.dart';
import 'package:http/http.dart' as http;

import '../widgets/blogWidgetInHomeScreen.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

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
    // fetchPosts();
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
      color: Color.fromRGBO(18, 18, 18, 1),
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
                        height: 140,
                        color: Color.fromRGBO(40, 40, 40, 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 60, left: 25),
                              height: 140,
                              // width: wi,
                              // color: Color.fromRGBO(18, 18, 18, 1),
                              color: Color.fromRGBO(40, 40, 40, 1),
                              child: Text(
                                'Blogs',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                            ConnectivityStatusWidget(),
                          ],
                        ),
                      ),
                      Positioned(
                        top:
                            110, // Position the second container 150 pixels from the top

                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(18, 18, 18, 1),
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
                  // Container(
                  //   height: hi * 0.15,
                  // ),
                  // Container(height: 8000, child: PostList()),
                  isLoading
                      ? Container(
                          color: Color.fromRGBO(18, 18, 18, 1),
                          height: hi - 140,
                          child: Center(
                            child:
                                CircularProgressIndicator(), // Show loading spinner
                          ),
                        )
                      : Container(
                          child: Text('helllo there where '),
                        ),
                  // Container(
                  //     // color: Color.fromRGBO(40, 40, 40, 1),
                  //     color: Color.fromRGBO(18, 18, 18, 1),
                  //     height: posts.length * 260,
                  //     child: ListView.builder(
                  //       physics: NeverScrollableScrollPhysics(),
                  //       itemCount: posts.length,
                  //       itemBuilder: (context, index) {
                  //         // return ListTile(
                  //         //   title: Text(posts[index].id),
                  //         //   subtitle: Text(posts[index].imageUrl),
                  //         // );
                  //         return CardWidget(posts[index], posts[index].id);
                  //       },
                  //     ),
                  //   ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ConnectivityController extends GetxController {
  Rx<ConnectivityResult> connectivityResult =
      Rx<ConnectivityResult>(ConnectivityResult.none);

  void checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    connectivityResult.value = result;
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize the connectivity check and set it in the state
    checkConnectivity();

    // Periodically check connectivity (e.g., every 5 seconds)
    Timer.periodic(Duration(seconds: 1), (_) {
      checkConnectivity();
    });
  }
}

class ConnectivityStatusWidget extends StatefulWidget {
  @override
  State<ConnectivityStatusWidget> createState() =>
      _ConnectivityStatusWidgetState();
}

class _ConnectivityStatusWidgetState extends State<ConnectivityStatusWidget> {
  final ConnectivityController controller = Get.put(ConnectivityController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final connectivityResult = controller.connectivityResult.value;
      Icon icon;
      Color iconColor;

      // Check the connectivity status and set the icon accordingly
      switch (connectivityResult) {
        case ConnectivityResult.none:
          icon = Icon(Icons.signal_wifi_off);
          iconColor = Colors.red;
          break;
        case ConnectivityResult.wifi:
        case ConnectivityResult.mobile:
          icon = Icon(Icons.signal_wifi_4_bar);
          iconColor = Colors.green;
          break;
        default:
          icon = Icon(Icons.warning);
          iconColor = Colors.yellow;
          break;
      }

      return Container(
        color: Color.fromRGBO(40, 40, 40, 1),
        margin: EdgeInsets.only(right: 20, top: 15),
        child: Icon(
          icon.icon,
          color: iconColor,
          size: 30,
        ),
      );
    });
  }
}
