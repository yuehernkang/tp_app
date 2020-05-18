import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = "/settingsPage";

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var html = """
<p><strong>Introduction and overview</strong></p>
<ul>
<li>Getting to know you…creatively!</li>
<li>Defining creativity</li>
<li>Your case study</li>
</ul>
<p><strong>Exploring the process</strong></p>
<ul>
<li>Design thinking – five key steps</li>
<li>Tips on how to brainstorm effectively</li>
<li>Facilitating ‘brainwriting’ and ‘braindump’ sessions</li>
</ul>
<p><strong>Framing the issues</strong></p>
<ul>
<li>Writing a problem statement</li>
<li>Doing a root cause analysis</li>
<li>Drawing a ‘why-why’ diagram</li>
</ul>
<p><strong>16 creativity tools</strong></p>
<ul>
<li>Understanding how to use the 16 techniques</li>
<li>Using the techniques on your case study</li>
<li>Reviewing the effectiveness of the techniques</li>
</ul>
""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: HtmlWidget(html),
    );
  }
}

class SettingsBody extends StatefulWidget {
  @override
  _SettingsBodyState createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
