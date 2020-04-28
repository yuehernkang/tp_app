import 'dart:async';

import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:tp_app/ui/app_bar/custom_app_bar.dart';
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

  static Algolia algolia = Algolia.init(
    applicationId: 'XVRTA8E4T1',
    apiKey: '0fdf05b6dc737d0f893b0136174644ae',
  );

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

  void queryAgolia(String querydata) async{
    AlgoliaQuery query =
        algolia.instance.index('prod_courses').search(querydata);

    // Get Result/Objects
    AlgoliaQuerySnapshot snap = await query.getObjects();

    // Checking if has [AlgoliaQuerySnapshot]
    print('\n\n');
    print('Hits count: ${snap.nbHits}');
    print('${snap.hits.map((e) => print(e.data))}');
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
          color: Theme.of(context).cardColor,
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
      _messages.insert(
          0, ChatMessage(text: message, buttons: buttons, user: true)
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
                onChanged: (text){
                  queryAgolia(text);
                },
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
      appBar: CustomAppBar(),
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
