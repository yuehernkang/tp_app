import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../repository/UserRepository.dart';
import '../../repository/bloc/authentication_bloc.dart';
import '../login_page/login_with_password.dart';

class TpDrawer extends StatelessWidget {
  final BuildContext context;
  final AuthenticationBloc authenticationBloc;
  const TpDrawer({Key key, this.context, this.authenticationBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            bloc: this.authenticationBloc,
            builder: (context, state) {
              if (state is Authenticated) {
                return DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text('TTTTTTTTTTTTTTTTT'),
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
                                builder: (context) => LoginWithPassword(authenticationBloc: this.authenticationBloc)));
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
            title: Text("Sign Out"),
            onTap: (){
              this.authenticationBloc.add(LoggedOut());
            },
          ),
        ],
      ),
    );
  }

  void changeBrightness() {
    DynamicTheme.of(this.context).setBrightness(
        Theme.of(this.context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }
}
