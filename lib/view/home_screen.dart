import 'package:flutter/material.dart';
import 'package:mvvm_architecture/model/user_model.dart';
import 'package:mvvm_architecture/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/routes/routes_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              InkWell(
                  onTap: (){
                    userPreference.remove().then((value) {
                      Navigator.pushNamed(context, RoutesName.login);
                    });
                  },
                  child: Text('Logout')),
            ],
          ),
        ),
      ),
    );
  }
}
