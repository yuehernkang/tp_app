import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import '../../constants.dart' as Constants;

class LoginPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget loginWidget() {
      return Column(
        children: <Widget>[
          OutlineButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(16.0)),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(FontAwesomeIcons.envelope),
                Text("Continue with email")
              ],
            ),
          ),
          OutlineButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(16.0)),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(FontAwesomeIcons.facebookSquare),
                Text("Continue with Facebook")
              ],
            ),
          )
        ],
      );
    }

    Widget registerWidget() {
      return Center(
        child: Container(
          child: Text("Register"),
        ),
      );
    }

    final tabContent = [
      loginWidget(),
      registerWidget(),
    ];
    return DefaultTabController(
      length: 2,
      child: PlatformScaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PlatformAppBar(
          android: (_) => MaterialAppBarData(
            bottom: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Theme.of(context).accentColor,
              unselectedLabelColor: Color(0xff5f6368),
              indicator: MD2Indicator(
                  indicatorHeight: 3,
                  indicatorColor: Theme.of(context).accentColor,
                  indicatorSize: MD2IndicatorSize.full),
              tabs: Constants.tabItems2,
            ),
          ),
        ),
        // appBar: AppBar(
        //   actions: <Widget>[],
        //   iconTheme: Theme.of(context).iconTheme,
        //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        //   // centerTitle: true,
        //   // title: Image.asset('assets/tplogo.png', height: kToolbarHeight),
        //   bottom: TabBar(
        //     isScrollable: true,
        //     indicatorSize: TabBarIndicatorSize.label,
        //     labelColor: Theme.of(context).accentColor,
        //     unselectedLabelColor: Color(0xff5f6368),
        //     indicator: MD2Indicator(
        //         indicatorHeight: 3,
        //         indicatorColor: Theme.of(context).accentColor,
        //         indicatorSize: MD2IndicatorSize.full),
        //     tabs: Constants.tabItems2,
        //   ),
        // ),
        body: TabBarView(
          children: tabContent,
        ),
      ),
    );
    ;
  }
}
