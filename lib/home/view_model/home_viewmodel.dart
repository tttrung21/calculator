
import 'package:calculator/enum/calculations.dart';
import 'package:calculator/model/item_pad_model.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeViewModel with ChangeNotifier {
  bool _hasComma = false;
  String _inputString = '0';
  List<String> _listInput = ['0'];
  double? _output;

  String get inputString => _inputString;

  double? get output => _output;

  void getInput(ItemPad item) {
    switch (item.calculations) {
      case Calculations.operation:
        _handleCalculation(item);
      case Calculations.equal:
        _handleEqual();
      case Calculations.delete:
        _handleDelete(item.name);
      case Calculations.comma:
        _handleComma();
      case Calculations.flip:
        _handleFlip();
      default:
        _handleNumberInput(item.name);
    }
    notifyListeners();
  }
  void _handleComma(){
    if(_hasComma == false) {
      _hasComma = true;
      _inputString += '.';
      _listInput.add('.');
    }
  }
  void _handleNumberInput(String number) {
    if (_inputString == '0') {
      _inputString = number;
    } else {
      _inputString += number;
    }
    _listInput.add(number);
  }

  void _handleCalculation(ItemPad item) {
    final lastItem = int.tryParse(_listInput.last);
    if(lastItem != null || _listInput.last == 'x-1') {
      _hasComma = false;
      _inputString = _inputString + item.name;
      _listInput.add(item.name);
    }

    notifyListeners();
  }

  void _handleFlip() {
    // print(_currentNumber);
    // _currentNumber[0] == '-'
    //     ? _currentNumber = _currentNumber.substring(1)
    //     : _currentNumber = '-$_currentNumber';
    _inputString += 'x-1';
    _listInput.add('x-1');
  }

  void _handleEqual() {
    String input = _inputString;
    input = input.replaceAll('x', '*').replaceAll('÷', '/');
    Parser p = Parser();
    Expression exp = p.parse(input);
    ContextModel ctx = ContextModel();
    _output = exp.evaluate(EvaluationType.REAL, ctx);
    print(_listInput);
    print(_inputString);
  }

  void _handleDelete(String name) {
    switch (name) {
      case 'DEL':
        if (_inputString.length == 1) {
          _inputString = '0';
          _listInput = ['0'];
        } else if (_inputString != '0') {
          _inputString = _inputString.substring(0, inputString.length - 1);
          _listInput.removeLast();
        }
      case 'C':
        _inputString = '0';
        _listInput = ['0'];
        _output = null;
    }
  }
}
