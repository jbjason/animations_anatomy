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
    _controller = PageController(initialPage: 0, viewportFraction: 0.8);
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
                  Image.asset('assets/starbuck/location.png'),
                  Image.asset('assets/starbuck/logo.png'),
                  Image.asset('assets/starbuck/drawer.png'),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) {
                  final _percent = (index - _value).abs();
                  return DrinkItem(drink: drinkList[index]);
                },
                itemCount: drinkList.length,
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
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
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
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _title() => Row(
        children: [
          Text(
            drink.name,
            style: TextStyle(
                color: drink.lightColor,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          Text(
            drink.conName,
            style: TextStyle(
                color: drink.darkColor,
                fontSize: 26,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 20),
              Image.asset('assets/stardust/cup_L.png'),
              const SizedBox(width: 10),
              Image.asset('assets/stardust/cup_M.png'),
              const SizedBox(width: 10),
              Image.asset('assets/stardust/cup_s.png'),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
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
                text: '\$',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                children: [
                  TextSpan(
                    text: '${drink.price.toInt()}.',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  TextSpan(
                    text: drink.price.toString().split('.')[1],
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      );
}
