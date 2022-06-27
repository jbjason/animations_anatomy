import 'package:flutter/material.dart';

class BankAppTitle extends StatelessWidget {
  const BankAppTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: const [
            Text('Hello ', style: TextStyle(fontSize: 20)),
            Expanded(
              child: Text(
                'Jb Jason',
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/card_/jb.jpg'),
            )
          ],
        ),
        Image.asset('assets/extra_/down-arrow.png',
            height: 20, width: 40, fit: BoxFit.cover),
      ],
    );
  }
}
