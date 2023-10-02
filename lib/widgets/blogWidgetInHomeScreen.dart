import 'dart:core';

import 'package:blog_explorer/models/blog.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CardWidget extends StatefulWidget {
  Blog blog;
  CardWidget(this.blog);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => PostsDetailScreen(widget.post)),
        // );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
        width: wi * 0.95,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color.fromRGBO(18, 18, 18, 1),
        ),
        child: Card(
          color: Color.fromRGBO(247, 255, 255, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 180,
                      child: CachedNetworkImage(
                        imageUrl: widget.blog.imageUrl,
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        placeholder: (BuildContext context, String url) =>
                            Container(
                          width: 320,
                          height: 240,
                          child: Text("no image to display "),
                        ),
                      ),
                    ),

                    Text(
                      widget.blog.title,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      maxLines: 2,
                    ),
                    // Container(height: 25),
                    // Text(
                    //   widget.blog.imageUrl,
                    //   style: TextStyle(
                    //     fontSize: 15,
                    //     color: Color.fromARGB(255, 51, 51, 51),
                    //   ),
                    //   maxLines: 5,
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // Row(
                    //   children: <Widget>[
                    //     const Spacer(),
                    //     TextButton(
                    //       style: TextButton.styleFrom(
                    //         foregroundColor: Colors.transparent,
                    //       ),
                    //       child: const Text(
                    //         "Edit",
                    //         style: TextStyle(
                    //             color: Colors.pinkAccent, fontSize: 18),
                    //       ),
                    //       onPressed: () {
                    //         // Navigator.push(
                    //         //   context,
                    //         //   MaterialPageRoute(
                    //         //       builder: (context) =>
                    //         //           PostsEditScreen()),
                    //         // );
                    //       },
                    //     ),
                    //     TextButton(
                    //       style: TextButton.styleFrom(
                    //         foregroundColor: Colors.transparent,
                    //       ),
                    //       child: const Text(
                    //         "Delete",
                    //         style: TextStyle(
                    //             color: Colors.pinkAccent, fontSize: 18),
                    //       ),
                    //       onPressed: () async {
                    //         // bool stat = await Provider.of<Posts>(context,
                    //         //         listen: false)
                    //         //     .deletePostFromDatabase(widget.post.id);
                    //         // if (stat == true) {
                    //         //   // ignore: use_build_context_synchronously
                    //         // }
                    //       },
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              Container(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
