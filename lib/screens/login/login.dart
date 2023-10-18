import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/screens/login/tabs/Login_tab.dart';
import 'package:to_do_app/screens/login/tabs/SignUp_tab.dart';
import 'package:to_do_app/shared/styles/colors.dart';

import '../../providers/my_provider.dart';

class LoginScreen1 extends StatelessWidget {
  static const String routeName = "LoginScreen";

  const LoginScreen1({super.key});

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: primary,
          title: Text("To Do"),
          bottom: PreferredSize(
            preferredSize:_tabBar.preferredSize,
            child: Material(
                color: primary,

                child:_tabBar
            ),
          ),
        ),
        body: TabBarView(children: [
          Center(
            child: LoginTab(),
          ),
          Center(
            child: SignUpTab(),
          ),
        ]),
      ),
    );
  }

  TabBar get _tabBar =>
      TabBar(
          tabs: [
            Tab(
              text: "Login",
            ),
            Tab(
              text: "Sign Up",
            ),
          ]
      );
}
