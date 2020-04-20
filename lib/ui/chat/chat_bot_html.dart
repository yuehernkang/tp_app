
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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