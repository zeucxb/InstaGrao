import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:instagrao/screens/upload/upload.screen.dart';
import 'package:instagrao/widgets/view/view.widget.dart';

class TimelineScreen extends StatefulWidget {
  TimelineScreen({Key key}) : super(key: key);

  @override
  _TimelineScreen createState() => _TimelineScreen();
}

class _TimelineScreen extends State<TimelineScreen> {
  final title = 'InstaGrão';
  final storage = new FlutterSecureStorage();

  final titleCtrl = TextEditingController();
  final titleFocus = FocusNode();
  final bodyCtrl = TextEditingController();
  final bodyFocus = FocusNode();

  int edditable;
  String username;
  List posts = [];

  _TimelineScreen() {}

  Future<List> getPosts() async {
    final postsStr = await storage.read(key: 'posts');

    return json.decode(postsStr);
  }

  updatePosts(List posts) async {
    await storage.write(key: 'posts', value: json.encode(posts));
  }

  updatePostByIndex(int index, Map post) async {
    posts[index] = post;

    await storage.write(key: 'posts', value: json.encode(posts));
  }

  bool isEdditable(int index) {
    return (edditable == index);
  }

  @override
  Widget build(BuildContext context) {
    storage.read(key: 'username').then((u) {
      username = u;
    });

    getPosts().then((p) {
      setState(() {
        posts = p;
      });
    });

    return View(
      title: title,
      enableScroll: false,
      showLogout: true,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UploadScreen(),
              ),
            );
          },
          tooltip: 'New post',
          backgroundColor: Colors.purple,
          child: Icon(Icons.add)),
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final item = posts[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      item['username'],
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    if (item['username'] == username)
                      Row(
                        children: <Widget>[
                          if (isEdditable(index))
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                size: 20,
                              ),
                              onPressed: () async {
                                posts.removeAt(index);
                                await updatePosts(posts);
                                setState(() {
                                  edditable = null;
                                });
                              },
                            ),
                          IconButton(
                            icon: Icon(
                              (isEdditable(index)) ? Icons.save : Icons.edit,
                              size: 20,
                            ),
                            onPressed: () async {
                              if (isEdditable(index)) {
                                item['title'] = titleCtrl.text;
                                item['body'] = bodyCtrl.text;

                                await updatePostByIndex(index, item);
                              }
                              setState(() {
                                if (isEdditable(index)) {
                                  edditable = null;
                                } else {
                                  titleCtrl.value = TextEditingValue(
                                      text: posts[index]['title']);
                                  bodyCtrl.value = TextEditingValue(
                                      text: posts[index]['body']);
                                  edditable = index;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                child: Image.file(
                  File(item['image']),
                  fit: BoxFit.cover,
                ),
                clipBehavior: Clip.antiAlias,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: (isEdditable(index))
                    ? EditableText(
                        controller: titleCtrl,
                        focusNode: titleFocus,
                        cursorColor: Colors.purple,
                        backgroundCursorColor: Colors.pink,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      )
                    : Text(
                        item['title'],
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: (isEdditable(index))
                    ? EditableText(
                        controller: bodyCtrl,
                        focusNode: bodyFocus,
                        cursorColor: Colors.purple,
                        backgroundCursorColor: Colors.pink,
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      )
                    : Text(
                        item['body'],
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
              ),
              Divider(
                color: Colors.grey.withOpacity(0.5),
                height: 0,
              )
            ],
          );
        },
      ),
    );
  }
}
