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
  bool isLiked = false;

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

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
          color: Color.fromRGBO(40, 40, 40, 1),
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
                      width: wi * 0.95,
                      child: CachedNetworkImage(
                        imageUrl: widget.blog.imageUrl,
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) => Center(
                          child: Text("Something went wrong ..."),
                        ),
                        placeholder: (BuildContext context, String url) =>
                            Container(
                          width: 320,
                          height: 240,
                          child: Center(child: Text("Loading...")),
                        ),
                      ),
                    ),
                    Container(
                      height: 52,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            width: wi * 0.75,
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
                            // margin: EdgeInsets.only(right: ),
                            child: Text(
                              widget.blog.title,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            // width: wi * 0.15,
                            margin: EdgeInsets.only(right: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: toggleLike,
                                  child: Icon(
                                    isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isLiked ? Colors.red : Colors.grey,
                                    size: 30.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
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
