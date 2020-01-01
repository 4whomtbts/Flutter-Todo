// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TodoList.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TodoList on _TodoList, Store {
  final _$listAtom = Atom(name: '_TodoList.list');

  @override
  ObservableList<TodoData> get list {
    _$listAtom.context.enforceReadPolicy(_$listAtom);
    _$listAtom.reportObserved();
    return super.list;
  }

  @override
  set list(ObservableList<TodoData> value) {
    _$listAtom.context.conditionallyRunInAction(() {
      super.list = value;
      _$listAtom.reportChanged();
    }, _$listAtom, name: '${_$listAtom.name}_set');
  }

  final _$_TodoListActionController = ActionController(name: '_TodoList');

  @override
  void addTodo(TodoData data) {
    final _$actionInfo = _$_TodoListActionController.startAction();
    try {
      return super.addTodo(data);
    } finally {
      _$_TodoListActionController.endAction(_$actionInfo);
    }
  }
}
