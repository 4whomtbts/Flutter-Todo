import 'dart:async';
import 'dart:collection';
import 'dart:core';
import 'dart:core';
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'TodoList.dart';

class AddTodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TodoForm();
  }
}

class TodoForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TodoFormState();
  }
}

class _TodoFormState extends State<TodoForm> {
  final titleController = TextEditingController();
  final categoryController = TextEditingController();
  final contentController = TextEditingController();
  final changeNotifier = StreamController.broadcast();

  final registerButton = RegisterTodoFloatingButton();

  HashMap<String, String> todoDataList = new HashMap();
  Set<TextEditingController> controllerSet;
  TodoData todoData;

  TodoData getTodoData() {
    return TodoData(
        titleController.text, categoryController.text, contentController.text);
  }

  bool registerTodo() {}

  void pushTodoData(String field, String data) {
      todoDataList[field] = data;

      if(todoDataList.length > 2) {
          this.todoData = TodoData(todoDataList['Title'], todoDataList["Category"], todoDataList["Content"]);
          todoList.addTodo(this.todoData);

      }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    changeNotifier.close();
    super.dispose();
  }

  _registerTodo(String field, TodoData data) {

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => changeNotifier.sink.add(null),
          child: const Icon(Icons.add),
        ),
        body: Column(children: [
          Expanded(
              flex: 2,
              child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.only(top: 20.0),
                      child: NonNullableTextField("Title", changeNotifier.stream, pushTodoData)
                  ))),
          Expanded(
              flex: 2,
              child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.only(top: 20.0),
                    child: NonNullableTextField("Category", changeNotifier.stream, pushTodoData),
                  ))),
          Expanded(
              flex: 6,
              child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.only(top: 20.0),
                      child: NonNullableTextField("Content", changeNotifier.stream, pushTodoData,
                          10, 10)
                  ))),
        ]));
  }
}

class NonNullableTextField extends StatefulWidget {
  final Stream registerValidation;
 _TextFieldState textFieldState;
  String _labelText;
  int _minLines;
  int _maxLines;
  Function(String, String) registerTodoCallBack;

  NonNullableTextField(this._labelText, this.registerValidation, this.registerTodoCallBack,
      [this._minLines = 1, this._maxLines = 1]) : assert(registerValidation != null);

  @override
  State<StatefulWidget> createState() {
    textFieldState = _TextFieldState(_labelText, _minLines, _maxLines);
    return textFieldState;
  }

}

class _TextFieldState extends State<NonNullableTextField> {
  TextField textField;
  TextEditingController textController = new TextEditingController();
  bool _isValid = true;
  String inputText = '';
  StreamSubscription streamSubscription;
  String _labelText= "";
  int _min;
  int _max;
  void setInputText(String inputText) {
    this.inputText = inputText;
  }

  _TextFieldState(String _labelText, [int _minLines = 1, int _maxLines = 1]) {
    this._labelText = _labelText;
    this._min = _minLines;
    this._max = _maxLines;
    /*
    textField = TextField(
        controller: textController,
        minLines: _minLines,
        maxLines: _maxLines,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: _labelText,
            errorText: _isValid ? null : _labelText + "field is required"));

     */
  }

  bool validate() {
    if (textController.text == '') {
      setState(() {
         this._isValid = false;
      });
      return false;
    }
    setState(() {
      this._isValid = true;
    });

    widget.registerTodoCallBack(_labelText, textController.text);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    log("$_min 과 $_max와 $_labelText");
    return TextField(
        controller: textController,
        minLines: _min,
        maxLines: _max,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: _labelText,
            errorText: _isValid ? null : _labelText + " field is required"));
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log("@$_min 과 $_max와 $_labelText");

    streamSubscription = widget.registerValidation.listen((_) => validate());
    textController.addListener(() {
        this.inputText = textController.text;
    });
  }

}

class RegisterTodoFloatingButton extends FloatingActionButton {
  BuildContext _context;

  void _registerTodo(TodoData) {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    this._context = context;

    return FloatingActionButton();
  }
}

class PercentOfParentWidth {
  double call(BuildContext context, double ratio) =>
      MediaQuery.of(context).size.width;
}

class PercentOfParentHeight {
  double call(BuildContext context, double ratio) =>
      MediaQuery.of(context).size.height;
}

class FlexSizedTextField extends StatelessWidget {
  int _flexFactor;
  String _placeHolder;
  int _height;

  FlexSizedTextField(this._flexFactor, this._height, this._placeHolder);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
        flex: this._flexFactor,
        child: Align(
            alignment: Alignment.center,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: this._placeHolder,
                  ),
                ))));
  }
}
