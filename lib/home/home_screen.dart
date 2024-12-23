import 'package:calculator/enum/calculations.dart';
import 'package:calculator/home/view_model/home_viewmodel.dart';
import 'package:calculator/home/widgets/custom_switch.dart';
import 'package:calculator/model/item_pad_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<ItemPad> buttons = const [
    ItemPad(name: "C", calculations: Calculations.delete),
    ItemPad(name: "+/-", calculations: Calculations.flip),
    ItemPad(name: "%", calculations: Calculations.operation),
    ItemPad(name: "÷", calculations: Calculations.operation),
    ItemPad(name: '7', calculations: Calculations.number),
    ItemPad(name: '8', calculations: Calculations.number),
    ItemPad(name: '9', calculations: Calculations.number),
    ItemPad(name: "x", calculations: Calculations.operation),
    ItemPad(name: '4', calculations: Calculations.number),
    ItemPad(name: '5', calculations: Calculations.number),
    ItemPad(name: '6', calculations: Calculations.number),
    ItemPad(name: "-", calculations: Calculations.operation),
    ItemPad(name: '1', calculations: Calculations.number),
    ItemPad(name: '2', calculations: Calculations.number),
    ItemPad(name: '3', calculations: Calculations.number),
    ItemPad(name: "+", calculations: Calculations.operation),
    ItemPad(name: ".", calculations: Calculations.comma),
    ItemPad(name: '0', calculations: Calculations.number),
    ItemPad(name: "DEL", calculations: Calculations.delete),
    ItemPad(name: "=", calculations: Calculations.equal),
  ];

  bool _isWidthBigger(double height, double width) {
    return width > height;
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      builder: (context, child) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: const CustomSwitch(),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(padding.left + 16, 4, padding.right + 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildInputOutput(context),
                const SizedBox(height: 8),
                _buildButtons(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputOutput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Selector<HomeViewModel, String>(
            selector: (context, vm) => vm.inputString,
            builder: (context, value, child) {
              return Container(
                alignment: Alignment.centerRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Text(value,
                      maxLines: 1,
                      softWrap: false,
                      textAlign: TextAlign.right,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(overflow: TextOverflow.ellipsis, height: 0)),
                ),
              );
            }),
        const SizedBox(height: 4),
        Selector<HomeViewModel, double?>(
            selector: (context, vm) => vm.output,
            builder: (context, value, child) {
              var output = value?.toString() ?? '0';
              return Container(
                alignment: Alignment.centerRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Text(
                    output,
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    softWrap: false,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(overflow: TextOverflow.ellipsis),
                  ),
                ),
              );
            }),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    final width = size.width;
    final ratio = (width + width) / height;
    return SizedBox(
      height: height / 2 + height / 6,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: _isWidthBigger(height, width) ? 3 : ratio,
            crossAxisCount: 4,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16),
        itemBuilder: (_, index) {
          final item = buttons[index];
          return _buildItem(item, index, context);
        },
        itemCount: buttons.length,
      ),
    );
  }

  Widget _buildItem(ItemPad item, int index, BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        context.read<HomeViewModel>().getInput(item);
      },
      padding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24), color: _getColor(index, context)),
        alignment: Alignment.center,
        child: item.calculations == Calculations.flip
            ? Image.asset('assets/Union.png', color: _getTextColor(index, context))
            : item.calculations == Calculations.delete && item.name == 'DEL'
                ? Image.asset('assets/delete.png', color: _getTextColor(index, context))
                : Text(
                    item.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400, color: _getTextColor(index, context)),
                  ),
      ),
    );
  }

  Color? _getTextColor(int index, BuildContext context) {
    switch (index) {
      case 3:
      case 7:
      case 11:
      case 15:
      case 19:
        return Colors.white;
      default:
        return Theme.of(context).primaryColorDark;
    }
  }

  Color? _getColor(int index, BuildContext context) {
    switch (index) {
      case < 3:
        return Theme.of(context).primaryColor;
      case 3:
      case 7:
      case 11:
      case 15:
      case 19:
        return Theme.of(context).indicatorColor;
      default:
        return Theme.of(context).cardColor;
    }
  }
}
