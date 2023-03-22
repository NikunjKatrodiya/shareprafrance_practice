import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shareprafrance_practice/data/todo_model.dart';
import 'package:shareprafrance_practice/screen/todo_add_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ToDoModel> appData = [];
  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    getInstance();

    super.initState();
  }

  getInstance() async {
    sharedPreferences = await SharedPreferences.getInstance();

    getToDoData();
  }

  getToDoData() {
    if (sharedPreferences!.containsKey("toDoData")) {
      dynamic data = sharedPreferences!.getString("toDoData");
      appData = (jsonDecode(data) as List?)!
          .map((dynamic e) => ToDoModel.fromJson(e))
          .toList();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => const Divider(),
          separatorBuilder: (context, index) => ListTile(
                title: Text("${appData[index].title}"),
                subtitle: Text("${appData[index].description}"),
              ),
          itemCount: appData.length),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ToDoAddScreen(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
