import 'package:animations_anatomy/models/trip.dart';
import 'package:flutter/material.dart';

class Sliver2Body extends StatelessWidget {
  const Sliver2Body({
    Key? key,
    required this.size,
    required this.trip,
  }) : super(key: key);

  final Size size;
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _CustomIcon(
                icon: Icons.stars,
                text: '89%',
              ),
              _CustomIcon(
                icon: Icons.tv,
                text: 'Netflix',
              ),
              _CustomIcon(
                icon: Icons.wc,
                text: 'Tv +14',
              ),
              _CustomIcon(
                icon: Icons.av_timer_rounded,
                text: '50m',
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              '''When a young boy disappears, his mother, a police chief, and his friend must confront terrifying forces in order to get him back.
                      ''',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 15),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15.0, bottom: 10),
            child: Text(
              'Related shows',
              style: TextStyle(fontSize: 23),
            ),
          ),
          // related images
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      height: size.height * 0.18,
                      width: size.width * 0.23,
                      image: AssetImage(trips[index].img),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text('Seansons', style: TextStyle(fontSize: 23)),
          ),
          _Features(
            size: size,
            title: 'Seanson 1',
            subtitle: '8 watched',
            colorline: Colors.red[300]!,
          ),
          _Features(
            size: size,
            title: 'Seanson 2',
            subtitle: '9 watched',
            colorline: Colors.red[300]!,
          ),
          _Features(
            size: size,
            title: 'Seanson 3',
            subtitle: '1 to air',
            colorline: Colors.grey[300]!,
          ),
          _Features(
            size: size,
            title: 'Specials',
            subtitle: '7 to watch',
            colorline: Colors.grey[300]!,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            height: 90,
            width: double.infinity,
            // ignore: deprecated_member_use
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Colors.yellow,
              child: const Text(
                'Add to Cart',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 1,
                    wordSpacing: 3),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomIcon extends StatelessWidget {
  const _CustomIcon({Key? key, required this.icon, required this.text})
      : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey, size: 45),
        Text(
          text,
          style: const TextStyle(fontSize: 20, color: Colors.grey),
        )
      ],
    );
  }
}

class _Features extends StatelessWidget {
  const _Features({
    Key? key,
    required this.size,
    required this.title,
    required this.subtitle,
    required this.colorline,
  }) : super(key: key);

  final Size size;
  final String title;
  final String subtitle;
  final Color colorline;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: size.width,
      color: Colors.white,
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 7),
                Text(subtitle, style: const TextStyle(fontSize: 16)),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Container(
                    height: 5,
                    color: colorline,
                  ),
                )
              ],
            ),
          ),
          Icon(Icons.pending, color: Colors.grey[400])
        ],
      ),
    );
  }
}
