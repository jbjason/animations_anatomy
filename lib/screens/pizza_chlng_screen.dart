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
            left: 7,
            right: 7,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: const [
                  Expanded(flex: 5, child: PizzaChlngDetails()),
                  Expanded(flex: 2, child: PizzaIngradients()),
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

class _PizzaChlngDetailsState extends State<PizzaChlngDetails> {
  int _total = 15;
  final List<Ingradient> _listIngredients = [];
  bool _isFocus = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: DragTarget<Ingradient>(
            onAccept: (ingradient) {
              print('OnAccept');
              setState(() => _isFocus = false);
            },
            onWillAccept: (ingradient) {
              print('onWillAccept');
              setState(() => _isFocus = true);
              for (Ingradient i in _listIngredients) {
                if (i.image == ingradient!.image) {
                  return false;
                }
              }
              _listIngredients.add(ingradient!);
              _total++;
              return true;
            },
            onLeave: (ingradient) {
              setState(() => _isFocus = false);
              print('OnLeave');
            },
            builder: (context, candidateData, rejectedData) {
              return LayoutBuilder(builder: (context, constrain) {
                return Center(
                  child: AnimatedContainer(
                    duration: _duration,
                    width:
                        _isFocus ? constrain.maxWidth : constrain.maxWidth - 10,
                    child: Stack(
                      children: [
                        Image.asset('assets/pizza_/dish.png'),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset('assets/pizza_/pizza-1.png'),
                        ),
                      ],
                    ),
                  ),
                );
              });
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
        height: 45,
        width: 45,
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: Color(0xFFF5EED3)),
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
    _controller = AnimationController(vsync: this, duration: _duration);
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
        await _controller.forward(from: 0.0);
        await _controller.reverse(from: 0.6);
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
              scale: (1 - _controller.value).clamp(0.6, 1.0), child: child!);
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
