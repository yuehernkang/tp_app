import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = "/settingsPage";

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var html = """
<p>With emerging Smart Nation trends such as the Internet of Things (IoT), data analytics, artificial intelligence, intelligent automation, cyber security and smart manufacturing &#x2014; there&#x2019;s definitely a great demand for computer engineers skilled in these enabling technologies. This course will empower you to become part of this vital Smart Nation talent pool. You will be proficient in both hardware and software, as well as the integration of both. This will give you a competitive edge over purely software or purely hardware-skilled professionals.</p>
<p>In your final year, you can choose one of these elective clusters: <br>&#x2022; Advanced Engineering Skills<br>&#x2022; Industrial Internet of Things<br>&#x2022; Virtual Reality</p>
<p>This course also prepares you for internationally recognised industry certification examinations such as those from National Instruments, CompTIA, Oracle, Microsoft and Cisco.</p>
""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: HtmlWidget(html),
      // body: Spinner(),
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

class Spinner extends StatefulWidget {
  @override
  _SpinnerState createState() => new _SpinnerState();
}

class _SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation _animation;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..forward();

    _animation = new CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) print(status);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      animation: _animation,
      child: new Container(width: 200.0, height: 200.0, color: Colors.green),
      builder: (BuildContext context, Widget child) {
        return new Transform.rotate(
          angle: _controller.value * 2.0 * 3.1415,
          child: child,
        );
      },
    );
  }
}
