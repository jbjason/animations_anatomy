import 'package:animations_anatomy/screens/challenges_/bank1_chlng/bank1_button.dart';
import 'package:flutter/material.dart';

class Bank1AnimatedPage extends StatelessWidget {
  const Bank1AnimatedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 50),
          const Text('425.0',
              style: TextStyle(fontSize: 100, fontWeight: FontWeight.w200)),
          const SizedBox(height: 50),
          _buttonRow(['AC', '+/-', '%', '÷']),
          _buttonRow(['7', '8', '9', 'x']),
          _buttonRow(['4', '5', '6', '-']),
          _buttonRow(['1', '2', '3', '+']),
          _buttonRow(['0', '.', '=']),
          Container(color: Colors.grey[900], height: size.padding.bottom),
        ],
      ),
    );
  }

  Widget _buttonRow(List<String> _list) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _list.length,
        itemBuilder: (context, index) {
          final text = _list[index];
          return text == '0'
              ? Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Bank1Button(text: text, isPill: true),
                )
              : Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Bank1Button(text: text),
                );
        },
      ),
    );
  }
}
