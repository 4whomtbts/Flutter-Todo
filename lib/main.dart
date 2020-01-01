import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_a/TodoList.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'AddTodoPage.dart';

void main() {
  runApp(
      MaterialApp(
        home : MyApp(),
        routes : <String, WidgetBuilder> {
          '/addTodo' : (BuildContext context) => AddTodoPage(), 
        },
      ));

}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  Widget _buildTodoList(List<TodoData> todoList) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {

          if(todoList.length == 0) {
            return null;
          }
          if(i.isOdd) return Divider();

          final index = i ~/ 2;
          // ignore: missing_return
          if(index >= todoList.length) {
            return null;
          }
          return _buildRow(todoList[index]);
        }
    );
  }

  Widget _buildRow(TodoData data) {
    return ListTile(
        title: Text(
          data.title,
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    // TODO: implement build
    return Scaffold(
      body: FractionallySizedBox(
        widthFactor: 1,
        heightFactor:1,
        child: Observer(
            builder : (_) =>_buildTodoList(todoList.list)),
      ),
      floatingActionButton: AddTodoFloatingButton(),
    );
  }



}
class AddTodoFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
       return FloatingActionButton(
         onPressed: () => Navigator.of(context).pushNamed('/addTodo'),
         child: const Icon(Icons.add),
       );
    }
}

