import 'package:flutter/material.dart';

class TopSearchContainer extends StatelessWidget {
  const TopSearchContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 45,
      margin: const EdgeInsets.only(left: 20, right: 20),
      width: width,
      child: Row(
        children: [
          Container(
            width: width * .8,
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
          const SizedBox(width: 10),
          const Icon(Icons.settings_applications_rounded)
        ],
      ),
    );
  }
}
