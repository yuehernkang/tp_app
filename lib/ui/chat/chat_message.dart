import 'package:flutter/material.dart';

import 'empty.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final List buttons;
  final bool user;
  //for opotional params we use curly braces
  ChatMessage({this.text, this.buttons, this.user});
  String _name = "You";

  Widget _buildButtons(List buttons) {
    if (buttons != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: buttons,
      );
    } else
      return Empty();
  }

  Widget _buildBot(BuildContext context) {
    return new Row(
      mainAxisAlignment:
          this.user ? MainAxisAlignment.start : MainAxisAlignment.end,
      crossAxisAlignment:
          this.user ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: <Widget>[
        new Container(
          margin: EdgeInsets.only(right: 16.0),
          child: new CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            child: new Text("yes"),
          ),
        ),
        new Column(
          crossAxisAlignment:
              this.user ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: <Widget>[
            new Text("Temasek Polytechnic", style: Theme.of(context).textTheme.subhead),
            new Container(
              alignment:
                  this.user ? Alignment.centerLeft : Alignment.centerRight,
              margin: const EdgeInsets.only(top: 5.0),
              child: Container(
                alignment:
                    this.user ? Alignment.centerLeft : Alignment.centerRight,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  text,
                ),
              ),
            ),
            _buildButtons(this.buttons)
          ],
        ),
      ],
    );
  }

  Widget _buildUser(BuildContext context) {
    return new Row(
      mainAxisAlignment:
          this.user ? MainAxisAlignment.start : MainAxisAlignment.end,
      crossAxisAlignment:
          this.user ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: <Widget>[
        new Column(
          crossAxisAlignment:
              this.user ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: <Widget>[
            new Text(_name, style: Theme.of(context).textTheme.subhead),
            new Container(
              alignment:
                  this.user ? Alignment.centerLeft : Alignment.centerRight,
              margin: const EdgeInsets.only(top: 5.0),
              child: Container(
                alignment:
                    this.user ? Alignment.centerLeft : Alignment.centerRight,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  text,
                ),
              ),
            ),
            _buildButtons(this.buttons)
          ],
        ),
        new Container(
          margin: EdgeInsets.only(left: 16.0),
          child: new CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            child: new Text("yes"),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: this.user ? _buildBot(context) : _buildUser(context));
  }
}
