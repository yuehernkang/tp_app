import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:webview_flutter/webview_flutter.dart';

Future<String> createAlbum(String message) async {
  final uri =
      'https://jointpoly-prd.mybluemix.net/api/message?{"input":{"text":"$message"},"context":{"conversation_id":"91a7167b-7fa7-46be-8c8d-61d8e03c22f2","system":{"initialized":true,"dialog_stack":[{"dialog_node":"root"}],"dialog_turn_counter":2,"dialog_request_counter":2,"branch_exited":true,"branch_exited_reason":"completed"},"iter":0,"course":"","school":"","counter":0,"netscore":"","crosspoly":false,"poly_array":[],"netscorenum":0,"polycontext":"Temasek Polytechnic","polytechnic":"Temasek Polytechnic","course_array":[],"school_array":[],"shortcourses":false,"npcoursefound":false,"rpcoursefound":false,"spcoursefound":false,"tpcoursefound":false,"disambiguation":false,"nypcoursefound":false,"iter_poly_array":0,"poly_comparison":false,"aboutcoursecheck":false,"artsstream_array":[],"iter_school_array":0,"admission_exercise":"","sciencestream_array":[],"courseinterest_array":[],"courserecommendation":false,"iter_artsstream_array":0,"moecourseinterest_array":[],"iter_sciencestream_array":0,"iter_courseinterest_array":0,"iter_moecourseinterest_array":0,"_id":"51c62f34-6613-4d6e-8f12-f81351a29028","prev_intent":"hi","nocourseinterest":true}}';
  final headers = {'Content-Type': 'application/json'};
  Map<String, dynamic> body = {
    'input': {'text': 'asd'}
  };
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await http.post(
    uri,
    headers: headers,
    // body: jsonBody,
    encoding: encoding,
  );
  print(response.body);
  print(response.request);
  return response.body;
}

const String _name = "You";

class ChatMessage extends StatelessWidget {
  final String text;
  //for opotional params we use curly braces
  ChatMessage({this.text});
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(
              child: new Text(_name[0]),
            ),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(_name, style: Theme.of(context).textTheme.subhead),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    text,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ChatPageHtml extends StatelessWidget {
  
  const ChatPageHtml({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chatting"),
      ),
      body: Webview());
  }
}

class Webview extends StatelessWidget {
  const Webview({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://temasekpoly-prd.mybluemix.net/bot.html',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
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
    ChatMessage chatMessage = new ChatMessage(text: text);
    setState(() {
      _messages.insert(0, chatMessage);
      createAlbum(text).then((value) => receivedMessage(value));
    });
  }

  void receivedMessage(String text) {
    setState(() {
      _messages.insert(0,
          ChatMessage(text: json.decode(text)['output']['text'][0].toString()));
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
