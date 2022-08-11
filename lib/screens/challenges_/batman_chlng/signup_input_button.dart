import 'package:flutter/material.dart';

class SignUpInputButton extends StatelessWidget {
  const SignUpInputButton({Key? key, required this.text, this.password = false})
      : super(key: key);
  final String text;
  final bool password;
  @override
  Widget build(BuildContext context) {
    final _border = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[800]!, width: 1.0));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
            labelText: text,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(color: Colors.grey[600]),
            enabledBorder: _border,
            border: _border,
            suffixIcon: password
                ? Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: UnconstrainedBox(
                      child: Image.asset('assets/batman_/batman_logo.png',
                          height: 20),
                    ),
                  )
                : null),
      ),
    );
  }
}
