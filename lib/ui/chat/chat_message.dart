import 'dart:convert';

import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:tp_app/ui/full_time_courses/ft_courses_detail.dart';

import 'empty.dart';

class ChatMessage extends StatelessWidget {
  final BuildContext context;
  final bool card;
  final String text;
  final List buttons;
  final bool user;
  ChatMessage({this.text, this.buttons, this.user, this.card, this.context});

  Widget _buildButtons(List buttons) {
    if (buttons != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: buttons,
      );
    } else
      return Empty();
  }

  Widget _buildCard() {
    if (card) {
      return Container(
        height: 150.0,
        width: 200.0,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CoursesDetail(
                          documentID: jsonDecode(text)['documentId'],
                        )));
          },
          child: Card(
            child: Column(
              children: <Widget>[
                Hero(
                  tag: jsonDecode(text)['courseCode'],
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            imageUrl: jsonDecode(text)['imageUrl'],
                            placeholder: (image, ctx) => Container(
                                width: 800,
                                child: AspectRatio(
                                  aspectRatio: 1900 / 783,
                                  child: BlurHash(
                                      hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I"),
                                )),
                          ),
                          // child: Image.asset(
                          //     this.localImagePath),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 2.0),
                        child: Text(
                          jsonDecode(text)['courseName'],
                          // style: Theme.of(context).primaryTextTheme.headline,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else
      return Empty();
  }

  Widget _buildBot(BuildContext context) {
    return Bubble(
      padding: BubbleEdges.all(8),
      shadowColor: Colors.red,
      nip: BubbleNip.leftTop,
      child: new Row(
        mainAxisAlignment:
            this.user ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment:
            this.user ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(left: 8.0, right: 8.0),
            child: new CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: new Text("TP"),
            ),
          ),
          new Column(
            crossAxisAlignment:
                this.user ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: <Widget>[
              new Text("Temasek Polytechnic",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              new Container(
                alignment:
                    this.user ? Alignment.centerLeft : Alignment.centerRight,
                margin: const EdgeInsets.only(top: 5.0),
                width: MediaQuery.of(context).size.width,
                child: Container(
                  alignment:
                      this.user ? Alignment.centerLeft : Alignment.centerRight,
                  // width: MediaQuery.of(context).size.width,
                  child: Text(
                    this.card ? " " : text,
                    softWrap: true
                  ),
                ),
              ),
              _buildButtons(this.buttons),
              _buildCard()
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUser(BuildContext context) {
    return Bubble(
      nip: BubbleNip.rightTop,
      color: Color.fromARGB(255, 225, 255, 199),
      child: new Row(
        mainAxisAlignment:
            this.user ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment:
            this.user ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: <Widget>[
          new Column(
            crossAxisAlignment:
                this.user ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: <Widget>[
              new Text("You", style: TextStyle(fontWeight: FontWeight.bold)),
              new Container(
                alignment:
                    this.user ? Alignment.centerLeft : Alignment.centerRight,
                margin: const EdgeInsets.only(top: 5.0),
                child: Container(
                  alignment:
                      this.user ? Alignment.centerLeft : Alignment.centerRight,
                  // width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(text, textAlign: TextAlign.right),
                ),
              ),
              _buildButtons(this.buttons)
            ],
          ),
          new Container(
            margin: EdgeInsets.only(left: 8.0, right: 8.0),
            child: new CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: new Text("You"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: this.user ? _buildBot(context) : _buildUser(context));
  }
}
