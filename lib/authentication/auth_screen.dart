import 'package:flutter/material.dart';
import 'package:foodpanda_sellers_app/authentication/register.dart';

import 'login.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.cyan,
                    Colors.amber,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
            ),
            title: const Text(
              "iFood",
              style: TextStyle(
                color: Colors.white,
                fontSize: 60,
                fontFamily: "Lobster",
              ),
            ),
            bottom: const TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              indicatorColor: Colors.white38,
              indicatorWeight: 6,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  text: "Login",
                ),
                Tab(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  text: "Register",
                )
              ],
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.amber,
                  Colors.cyan,
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: const TabBarView(
              children: [
                LoginScreen(),
                RegisterScreen(),
              ],
            ),
          ),
        ));
  }
}
