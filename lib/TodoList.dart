import 'package:mobx/mobx.dart';

import 'TodoList.dart';

// Include generated file
part 'TodoList.g.dart';

// This is the class used by rest of your codebase
class TodoList = _TodoList with _$TodoList;

// The store-class
abstract class _TodoList with Store {
  @observable
  ObservableList<TodoData> list = ObservableList<TodoData>();

  @action
  void addTodo(TodoData data) {
    list.add(data);
  }
}

class TodoData {
  String title;
  String category;
  String content;

  TodoData(this.title, this.category, this.content);
}

TodoList todoList = TodoList();