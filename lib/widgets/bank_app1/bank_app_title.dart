import 'package:flutter/material.dart';

class BankAppTitle extends StatelessWidget {
  const BankAppTitle({Key? key, required this.onTap, required this.isExpand})
      : super(key: key);
  final void Function() onTap;
  final bool isExpand;
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
        InkWell(
          onTap: () => isExpand ? null : onTap(),
          child: isExpand
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text('Drag up', style: TextStyle(color: Colors.grey)),
                    Icon(Icons.arrow_upward_sharp, color: Colors.grey)
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text('Drag down', style: TextStyle(color: Colors.grey)),
                    Icon(Icons.arrow_downward_sharp, color: Colors.grey)
                  ],
                ),
        ),
      ],
    );
  }
}
