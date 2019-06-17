import 'package:flutter/material.dart';
import 'package:instagrao/screens/upload/upload.screen.dart';

import 'package:instagrao/widgets/view/view.widget.dart';

class TimelineScreen extends StatefulWidget {
  TimelineScreen({Key key}) : super(key: key);

  @override
  _TimelineScreen createState() => _TimelineScreen();
}

class _TimelineScreen extends State<TimelineScreen> {
  final items = List<Map<String, String>>.generate(
      3,
      (i) => {
            'nick': 'zeucxb',
            'title': 'Item ${i + 1}',
            'body':
                'Film Title adjsjdjakldjsa daklsjdkjasldjskaljdksaljdlas dsajkdljaslkjdsajdkljsakdjlajdljlkasjdlkjald asdjksajdlksajdjsakdjkasjdklajsdkjasljdklasjdklsajkdjksajdklsd dljaskjdakjdklsjaksdjkaljdklasjdklsjaldkjsakldjlskajdklsjdkljadlksjdklajkldjasjdklas'
          });

  final titleCtrl = TextEditingController();
  final titleFocus = FocusNode();
  final bodyCtrl = TextEditingController();
  final bodyFocus = FocusNode();

  int edditable;

  @override
  Widget build(BuildContext context) {
    final title = 'InstaGrão';

    return View(
      title: title,
      enableScroll: false,
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
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

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
                      'zeucxb',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    if (item['nick'] == 'zeucxb')
                      IconButton(
                        icon: Icon(
                          (edditable == index) ? Icons.save : Icons.edit,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            if (edditable == index) {
                              item['title'] = titleCtrl.text;
                              item['body'] = bodyCtrl.text;
                              edditable = null;
                            } else {
                              titleCtrl.value =
                                  TextEditingValue(text: items[index]['title']);
                              bodyCtrl.value =
                                  TextEditingValue(text: items[index]['body']);
                              edditable = index;
                            }
                          });
                        },
                      )
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                child: Image.network(
                  'https://placeimg.com/640/480/any',
                  fit: BoxFit.cover,
                ),
                clipBehavior: Clip.antiAlias,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: (edditable == index)
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
                child: (edditable == index)
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
