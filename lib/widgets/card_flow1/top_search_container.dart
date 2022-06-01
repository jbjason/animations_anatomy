import 'package:flutter/material.dart';

class TopSearchContainer extends StatelessWidget {
  const TopSearchContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 45,
      margin: const EdgeInsets.only(left: 30, right: 20),
      width: width,
      child: Row(
        children: [
          Container(
            width: width * .75,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color(0xFF9FB4D2)),
            child: Row(
              children: const [
                Icon(Icons.search_sharp),
                SizedBox(width: 10),
                Text('Search...')
              ],
            ),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.settings, color: Colors.white, size: 30)
        ],
      ),
    );
  }
}
