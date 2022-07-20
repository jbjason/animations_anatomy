import 'package:animations_anatomy/models/ingredient.dart';
import 'package:flutter/material.dart';

const _pizzaCartSize = 55.0;
const _duration = Duration(milliseconds: 300);

class PizzaChlngScreen extends StatelessWidget {
  const PizzaChlngScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Dominoz De Lata',
          style: TextStyle(color: Colors.brown, fontSize: 24),
        ),
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.brown)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.brown),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 50,
            left: 10,
            right: 10,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: const [
                  Expanded(flex: 6, child: PizzaChlngDetails()),
                  Expanded(flex: 3, child: PizzaIngradients()),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: size.width / 2 - _pizzaCartSize / 2,
            height: _pizzaCartSize,
            width: _pizzaCartSize,
            child: PizzaCartButton(onPress: () {}),
          )
        ],
      ),
    );
  }
}

class PizzaChlngDetails extends StatefulWidget {
  const PizzaChlngDetails({Key? key}) : super(key: key);

  @override
  State<PizzaChlngDetails> createState() => _PizzaChlngDetailsState();
}

class _PizzaChlngDetailsState extends State<PizzaChlngDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _total = 15;
  final List<Ingradient> _listIngredients = [];
  final _isFocus = ValueNotifier(false);
  final List<Animation> _animationList = [];
  late BoxConstraints _pizzaConstraints;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: _duration);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _buildIngradientAnimation() {
    _animationList.clear();
    _animationList.add(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, .8, curve: Curves.decelerate)));
    _animationList.add(CurvedAnimation(
        parent: _controller,
        curve: const Interval(.2, .8, curve: Curves.decelerate)));
    _animationList.add(CurvedAnimation(
        parent: _controller,
        curve: const Interval(.4, 1, curve: Curves.decelerate)));
    _animationList.add(CurvedAnimation(
        parent: _controller,
        curve: const Interval(.1, .7, curve: Curves.decelerate)));
    _animationList.add(CurvedAnimation(
        parent: _controller,
        curve: const Interval(.3, 1, curve: Curves.decelerate)));
  }

  Widget _buildIngradientsWidget() {
    if (_listIngredients.isNotEmpty) {
      List<Widget> elements = [];
      for (int i = 0; i < _listIngredients.length; i++) {
        Ingradient ingradient = _listIngredients[i];
        final image = Image.asset(ingradient.imageUnit, height: 25);
        for (int j = 0; j < ingradient.positions.length; j++) {
          final Animation animation = _animationList[j];
          double positionX = ingradient.positions[j].dx;
          double positionY = ingradient.positions[j].dy;
          // last added _list item would have animation only not others
          if (i == _listIngredients.length - 1) {
            double fromX = 0, fromY = 0;
            // first animated item & second & so on..
            if (j == 0) {
              fromX = -_pizzaConstraints.maxWidth * (1 - animation.value);
            } else if (j == 1) {
              fromX = _pizzaConstraints.maxWidth * (1 - animation.value);
            } else if (j == 2) {
              fromY = -_pizzaConstraints.maxHeight * (1 - animation.value);
            } else {
              fromY = _pizzaConstraints.maxHeight * (1 - animation.value);
            }
            elements.add(
              Transform(
                transform: Matrix4.identity()
                  ..translate(
                    fromX + _pizzaConstraints.maxWidth * positionX,
                    fromY + _pizzaConstraints.maxHeight * positionY,
                  ),
                child: image,
              ),
            );
          } else {
            // if _list item isn't the last added item then with no animation
            elements.add(
              Transform(
                transform: Matrix4.identity()
                  ..translate(
                    _pizzaConstraints.maxWidth * positionX,
                    _pizzaConstraints.maxHeight * positionY,
                  ),
                child: image,
              ),
            );
          }
        }
      }
      return Stack(children: elements);
    }
    return SizedBox.fromSize();
  }

  void _onAccept(Ingradient ingradient) {
    _isFocus.value = false;
    _total++;
    setState(() {});
    _buildIngradientAnimation();
    _controller.forward(from: 0.0);
  }

  bool _onWillAccept(Ingradient ingradient) {
    _isFocus.value = true;
    for (Ingradient i in _listIngredients) {
      if (i.image == ingradient.image) {
        return false;
      }
    }
    _listIngredients.add(ingradient);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: DragTarget<Ingradient>(
            onAccept: (ingradient) {
              print('OnAccept');
              _onAccept(ingradient);
            },
            onWillAccept: (ingradient) {
              print('onWillAccept');
              return _onWillAccept(ingradient!);
            },
            onLeave: (ingradient) {
              _isFocus.value = false;
              print('OnLeave');
            },
            builder: (context, candidateData, rejectedData) {
              return LayoutBuilder(
                builder: (context, constrain) {
                  _pizzaConstraints = constrain;
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Center(
                        child: ValueListenableBuilder<bool>(
                          valueListenable: _isFocus,
                          builder: (context, focused, _) {
                            return AnimatedContainer(
                              duration: _duration,
                              width: focused
                                  ? constrain.maxWidth - 30
                                  : constrain.maxWidth - 40,
                              child: Stack(
                                children: [
                                  Image.asset('assets/pizza_/dish.png'),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset(
                                        'assets/pizza_/pizza-1.png'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, _) => _buildIngradientsWidget(),
                      )
                    ],
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 5),
        AnimatedSwitcher(
          duration: _duration,
          transitionBuilder: (child, animation) {
            return SlideTransition(
              position: animation.drive(Tween<Offset>(
                  begin: const Offset(0, 0), end: Offset(0, animation.value))),
              child: child,
            );
          },
          child: Text(
            '\$$_total',
            key: UniqueKey(),
            style: const TextStyle(fontSize: 30, color: Colors.brown),
          ),
        ),
      ],
    );
  }
}

class PizzaIngradients extends StatelessWidget {
  const PizzaIngradients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: ingradients.length,
      itemBuilder: (context, index) =>
          PizzaIngradientItem(ingradient: ingradients[index]),
    );
  }
}

class PizzaIngradientItem extends StatelessWidget {
  const PizzaIngradientItem({Key? key, required this.ingradient})
      : super(key: key);
  final Ingradient ingradient;

  @override
  Widget build(BuildContext context) {
    final _child = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Container(
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFF5EED3),
          boxShadow: [
            BoxShadow(
                blurRadius: 10.0,
                color: Colors.black26,
                spreadRadius: 5.0,
                offset: Offset(0, 5))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(ingradient.image, fit: BoxFit.contain),
        ),
      ),
    );
    return Center(
        child: Draggable(feedback: _child, data: ingradient, child: _child));
  }
}

class PizzaCartButton extends StatefulWidget {
  const PizzaCartButton({Key? key, required this.onPress}) : super(key: key);
  final VoidCallback onPress;
  @override
  State<PizzaCartButton> createState() => _PizzaCartButtonState();
}

class _PizzaCartButtonState extends State<PizzaCartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      reverseDuration: const Duration(milliseconds: 200),
      lowerBound: 1.0,
      upperBound: 1.5,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        widget.onPress();
        await _controller.forward();
        await _controller.reverse();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(scale: 2 - _controller.value, child: child!);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(colors: [
              Colors.orange.withOpacity(0.5),
              Colors.orange,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 15,
                offset: Offset(0, 4),
                spreadRadius: 4.0,
              )
            ],
          ),
          child: const Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
