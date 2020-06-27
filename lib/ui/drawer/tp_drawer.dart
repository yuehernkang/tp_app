import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:tp_app/ui/login_page/login_page_2.dart';
import 'package:tp_app/ui/settings/settings.dart';

import '../../repository/authentication_bloc/authentication_bloc.dart';
import '../login_page/login_page.dart';

class TpDrawer extends StatelessWidget {
  final BuildContext context;

  const TpDrawer({Key key, this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            bloc: _authenticationBloc,
            builder: (context, state) {
              if (state is Authenticated) {
                return DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text('Temasek Polytechnic'),
                      Container(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(state.displayName),
                              Text('Prospective Student')
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                  ),
                );
              }
              return DrawerHeader(
                child: Column(
                  children: <Widget>[
                    MaterialButton(
                      child: Text("Login/Register"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                //TODO: use route generator instead
                                // builder: (context) => LoginWithPassword(authenticationBloc: this.widget.authenticationBloc))
                                builder: (context) => BlocProvider.value(
                                      value: _authenticationBloc,
                                      child: LoginPage2(),
                                    )));
                      },
                    )
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: Text("Dark Theme"),
            trailing: PlatformSwitch(
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (_) => changeBrightness(),
            ),
          ),
          ListTile(
            title: Text("Settings"),
            onTap: () {
              Navigator.pushNamed(context, SettingsPage.routeName);
            },
          ),
          ListTile(
            title: Text("Sign Out"),
            onTap: () {
              _authenticationBloc.add(LoggedOut());
            },
          ),
        ],
      ),
    );
  }

  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }
}
