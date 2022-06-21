import 'package:animations_anatomy/models/drink.dart';
import 'package:flutter/material.dart';

class StarbuckChallenge extends StatefulWidget {
  const StarbuckChallenge({Key? key}) : super(key: key);
  @override
  State<StarbuckChallenge> createState() => _StarbuckChallengeState();
}

class _StarbuckChallengeState extends State<StarbuckChallenge> {
  late final PageController _controller;
  double _value = 0.0;

  @override
  void initState() {
    _controller = PageController(initialPage: 0, viewportFraction: 0.9);
    _controller.addListener(_listen);
    super.initState();
  }

  void _listen() => setState(() => _value = _controller.page!);

  @override
  void dispose() {
    _controller.removeListener(_listen);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 80,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/starbuck/location.png', height: 20),
                  Image.asset('assets/starbuck/logo.png'),
                  Image.asset('assets/starbuck/drawer.png', height: 20),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: PageView.builder(
                  controller: _controller,
                  itemBuilder: (context, index) {
                    final _percent = (index - _value).abs();
                    return DrinkItem(drink: drinkList[index]);
                  },
                  itemCount: drinkList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrinkItem extends StatelessWidget {
  const DrinkItem({Key? key, required this.drink}) : super(key: key);
  final Drink drink;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _title(),
        const SizedBox(height: 60),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: AssetImage(drink.backgroundImage), fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                _column(),
              ],
            ),
          ),
        ),
        const SizedBox(height: 70),
      ],
    );
  }

  Widget _title() => Row(
        children: [
          Text(
            drink.name,
            style: TextStyle(
                color: drink.lightColor,
                fontSize: 34,
                fontWeight: FontWeight.bold),
          ),
          Text(
            drink.conName,
            style: TextStyle(
                color: drink.darkColor,
                fontSize: 35,
                fontWeight: FontWeight.bold),
          ),
        ],
      );

  Widget _column() => Column(
        children: [
          const Text(
            'Frappuccino',
            style: TextStyle(
                color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Text(
            drink.description,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            style: TextStyle(color: Colors.white.withOpacity(0.3)),
          ),
          const Spacer(),
          Container(
            height: 60,
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(width: 20),
                Image.asset('assets/starbuck/cup_L.png', height: 40),
                const SizedBox(width: 7),
                Image.asset('assets/starbuck/cup_M.png', height: 30),
                const SizedBox(width: 7),
                Image.asset('assets/starbuck/cup_s.png', height: 20),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            height: 60,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              gradient: LinearGradient(
                colors: [mAppGreen, mToGreen],
                stops: const [0.2, 1.0],
              ),
            ),
            child: RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: '\$ ',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
                children: [
                  TextSpan(
                    text: '${drink.price.toInt()}.',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  TextSpan(
                    text: drink.price.toString().split('.')[1],
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      );
}
