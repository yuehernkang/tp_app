import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:tp_app/ui/chat/chat_message.dart';


Future<List> dialogFlowChat(String message) async {
  AuthGoogle authGoogle =
      await AuthGoogle(fileJson: "assets/tp-app-aff2e-155c26bd1dad.json")
          .build();
  Dialogflow dialogflow =
      Dialogflow(authGoogle: authGoogle, language: Language.english);
  AIResponse response = await dialogflow.detectIntent(message);
  return response.getListMessage();
}

class ChatPage extends StatefulWidget {
  static const String routeName = "/chatPage";

  @override
  State createState() => new ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final TextEditingController textEditingController =
      new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];

  void _handleSubmit(String text) {
    textEditingController.clear();
    ChatMessage chatMessage = new ChatMessage(text: text, user: false);
    setState(() {
      _messages.insert(0, chatMessage);
      // createAlbum(text).then((value) => receivedMessage(value));
      // createAlbum(text).then((value) => print(value));
      dialogFlowChat(text).then((value) => receivedMessage(value));
    });
  }

  void receivedMessage(List text) {
    print(text);
    String message = text[0]['text']['text'][0];
    var arr = List();
    List<Widget> buttons = List();

    try {
      arr = text[1]['payload']['buttons'];
    } catch (e) {
      //RangeError (index): Invalid value: Only valid value is 0: 1
      print("bad payload");
      arr = null;
      print(e);
    }
    if (arr != null) {
      print("array not null");
      arr.forEach((f) {
        buttons.add(RaisedButton(
          child: Text(f),
          onPressed: () {
            _handleSubmit(f);
          },
        ));
      });
    }

    if (text == null) {
      message = "error";
      print("message is null");
    }
    //return array from payload
    // print(text[1]['payload']['buttons']);
    setState(() {
      _messages.insert(0, ChatMessage(text: message, buttons: buttons, user: true)
          // ChatMessage(text: json.decode(text)[0]['text']['text'][0])
          );
    });
  }

  Widget _textComposerWidget() {
    return new IconTheme(
      data: new IconThemeData(color: Colors.blue),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                decoration: new InputDecoration.collapsed(
                    hintText: "Enter your message"),
                controller: textEditingController,
                onSubmitted: _handleSubmit,
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => _handleSubmit(textEditingController.text),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          new Divider(
            height: 1.0,
          ),
          new Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _textComposerWidget(),
          )
        ],
      ),
    );
  }
}
