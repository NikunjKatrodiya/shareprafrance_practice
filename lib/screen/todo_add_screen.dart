import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shareprafrance_practice/data/todo_model.dart';
import 'package:shareprafrance_practice/screen/home_screen.dart';

class ToDoAddScreen extends StatefulWidget {
  const ToDoAddScreen({Key? key}) : super(key: key);

  @override
  State<ToDoAddScreen> createState() => _ToDoAddScreenState();
}

class _ToDoAddScreenState extends State<ToDoAddScreen> {
  SharedPreferences? sharedPreferences;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<ToDoModel> appData = [];
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

  setDataInModel() {
    appData.add(ToDoModel(title: titleController.text, description: descriptionController.text));
    setState(() {});
    setDataInSF();
  }

  getToDoData() {
    if (sharedPreferences!.containsKey("toDoData")) {
      dynamic data = sharedPreferences!.getString("toDoData");
      appData = (jsonDecode(data) as List?)!.map((dynamic e) => ToDoModel.fromJson(e)).toList();
      setState(() {});
    }
  }

  setDataInSF() {
    sharedPreferences!.setString("toDoData", jsonEncode(appData));
    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ToDo Add Screen"),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(
              height: 50,
            ),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintText: "Enter Title",
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              minLines: 3,
              maxLines: 7,
              controller: descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintText: "Description",
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  setDataInModel();
                  setState(() {

                  });
                },
                child: const Text("Add ToDo ")),
          ],
        ));
  }
}
