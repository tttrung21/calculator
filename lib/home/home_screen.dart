import 'package:calculator/enum/calculations.dart';
import 'package:calculator/home/view_model/home_viewmodel.dart';
import 'package:calculator/home/widgets/custom_switch.dart';
import 'package:calculator/model/item_pad_model.dart';
import 'package:calculator/utils/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Num pad
  // ['C', '+/-', '%' , '/']
  // ['7',  '8' , '9' , 'x']
  // ['4',  '5' , '6' , '-']
  // ['1',  '2' , '3' , '+']
  // ['.',  '0' ,'DEL', '=']
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

  // bool _isWidthBigger(double height, double width) {
  //   return width > height;
  // }

  @override
  Widget build(BuildContext context) {
    bool isPortrait = MediaQuery.orientationOf(context) == Orientation.portrait;
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
          child: isPortrait
              ? _buildBody(context)
              : SingleChildScrollView(
                  child: _buildBody(context),
                ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // const Spacer(),
        _buildInputOutput(context),
        // Flexible(flex: 5, fit: FlexFit.loose, child: _buildButtons(context)),
        _buildListButtons(context)
      ],
    );
  }

  Widget _buildInputOutput(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: 16,
      children: [
        Selector<HomeViewModel, String>(
            selector: (context, vm) => vm.inputString,
            builder: (context, value, child) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
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
                          ?.copyWith(overflow: TextOverflow.ellipsis)),
                ),
              );
            }),
        Selector<HomeViewModel, double?>(
            selector: (context, vm) => vm.output,
            builder: (context, value, child) {
              var output = value?.toString() ?? '0';
              return Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 8),
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

  /// Gridview
  // Widget _buildButtons(BuildContext context) {
  //   final size = MediaQuery.sizeOf(context);
  //   final height = size.height;
  //   final width = size.width;
  //   final ratio = (width + width) / height;
  //   return GridView.builder(
  //     padding: const EdgeInsets.symmetric(vertical: 12),
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //         childAspectRatio: _isWidthBigger(height, width) ? 3 : ratio,
  //         // mainAxisExtent: width / 5.5,
  //         crossAxisCount: 4,
  //         mainAxisSpacing: 16,
  //         crossAxisSpacing: 16),
  //     itemBuilder: (_, index) {
  //       final item = buttons[index];
  //       return _buildItem(item, index, context);
  //     },
  //     itemCount: buttons.length,
  //   );
  // }

  // Widget _buildItem(ItemPad item, int index, BuildContext context) {
  //   return CupertinoButton(
  //     onPressed: () {
  //       context.read<HomeViewModel>().getInput(item);
  //       final msg = context.read<HomeViewModel>().errorMsg;
  //       if (msg != null && item.calculations == Calculations.equal) {
  //         CustomSnackBar.showError(msg, context);
  //       }
  //     },
  //     padding: EdgeInsets.zero,
  //     child: Container(
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(24), color: _getColor(index, context)),
  //       alignment: Alignment.center,
  //       child: item.calculations == Calculations.flip
  //           ? Image.asset('assets/Union.png', color: _getTextColor(index, context))
  //           : item.calculations == Calculations.delete && item.name == 'DEL'
  //               ? Image.asset('assets/delete.png', color: _getTextColor(index, context))
  //               : Text(
  //                   item.name,
  //                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
  //                       fontWeight: FontWeight.w400, color: _getTextColor(index, context)),
  //                 ),
  //     ),
  //   );
  // }

  /// Column and rows
  Widget _buildListButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [for (int i = 0; i <= 3; i++) _buildItem(buttons[i], i, context)],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [for (int i = 4; i <= 7; i++) _buildItem(buttons[i], i, context)],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [for (int i = 8; i <= 11; i++) _buildItem(buttons[i], i, context)],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [for (int i = 12; i <= 15; i++) _buildItem(buttons[i], i, context)],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [for (int i = 16; i <= 19; i++) _buildItem(buttons[i], i, context)],
          ),
        ],
      ),
    );
  }

  Widget _buildItem(ItemPad item, int index, BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    return Expanded(
      child: CupertinoButton(
        onPressed: () {
          context.read<HomeViewModel>().getInput(item);
          final msg = context.read<HomeViewModel>().errorMsg;
          if (msg != null && item.calculations == Calculations.equal) {
            CustomSnackBar.showError(msg, context);
          }
        },
        padding: const EdgeInsets.all(8),
        child: Container(
          height: height / 11.5,
          // width: width / 5.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24), color: _getColor(index, context)),
          alignment: Alignment.center,
          child: item.calculations == Calculations.flip
              ? Image.asset('assets/Union.png', color: _getTextColor(index, context))
              : item.calculations == Calculations.delete && item.name == 'DEL'
                  ? Image.asset('assets/delete.png', color: _getTextColor(index, context))
                  : Text(
                      item.name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400, color: _getTextColor(index, context)),
                    ),
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
