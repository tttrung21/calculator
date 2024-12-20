import 'package:calculator/enum/calculations.dart';
import 'package:calculator/model/item_pad_model.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeViewModel with ChangeNotifier {
  bool _hasComma = false;
  String _inputString = '0';
  String _currentNumber = '';
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
    }
  }
  void _handleNumberInput(String number) {
    if (_inputString == '0') {
      _inputString = number;
      _currentNumber = number;
    } else {
      _inputString += number;
      _currentNumber += number;
    }
  }

  void _handleCalculation(ItemPad item) {
    _hasComma = false;
    _currentNumber = '';
    _inputString = _inputString + item.name;
    notifyListeners();
  }

  void _handleFlip() {
    // print(_currentNumber);
    // _currentNumber[0] == '-'
    //     ? _currentNumber = _currentNumber.substring(1)
    //     : _currentNumber = '-$_currentNumber';
    _inputString[0] == '-'
        ? _inputString = _inputString.substring(1)
        : _inputString = '-$_inputString';
  }

  void _handleEqual() {
    String input = _inputString;
    input = input.replaceAll('x', '*').replaceAll('÷', '/');
    Parser p = Parser();
    Expression exp = p.parse(input);
    ContextModel ctx = ContextModel();
    _output = exp.evaluate(EvaluationType.REAL, ctx);
  }

  void _handleDelete(String name) {
    switch (name) {
      case 'DEL':
        if (_inputString.length == 1) {
          _inputString = '0';
        } else if (_inputString != '0') {
          _inputString = _inputString.substring(0, inputString.length - 1);
        }
      case 'C':
        _inputString = '0';
        _output = null;
    }
  }
}
