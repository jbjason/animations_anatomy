import 'package:animations_anatomy/models/pizza.dart';
import 'package:animations_anatomy/provider/pizza_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _duration = Duration(milliseconds: 300);

class PizzaChlngDetails extends StatefulWidget {
  const PizzaChlngDetails({Key? key}) : super(key: key);
  @override
  State<PizzaChlngDetails> createState() => _PizzaChlngDetailsState();
}

class _PizzaChlngDetailsState extends State<PizzaChlngDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _isFocus = ValueNotifier(false);
  final List<Animation> _animationList = [];
  late BoxConstraints _pizzaConstraints;
  final _notifierPizzaSize =
      ValueNotifier<PizzaSizeState>(PizzaSizeState(value: PizzaSizeValue.M));

  @override
  void initState() {
    Provider.of<PizzaBloc>(context, listen: false).setInitialList();
    _controller = AnimationController(vsync: this, duration: _duration);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _buildIngredientAnimation() {
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

  Widget _buildIngredientsWidget(List<Ingredient> _deleteIngredient) {
    List<Widget> elements = [];
    // List.from() it returns a fixed-length list cz _controller.reverse() call this funtion multiple(7) times
    final _listIngredients = List.from(
        Provider.of<PizzaBloc>(context, listen: false).listIngredients);
    if (_deleteIngredient.isNotEmpty) {
      _listIngredients.add(_deleteIngredient[0]);
    }
    if (_listIngredients.isNotEmpty) {
      for (int i = 0; i < _listIngredients.length; i++) {
        Ingredient ingredient = _listIngredients[i];
        final image = Image.asset(ingredient.imageUnit, height: 25);
        for (int j = 0; j < ingredient.positions.length; j++) {
          final Animation animation = _animationList[j];
          double positionX = ingredient.positions[j].dx;
          double positionY = ingredient.positions[j].dy;
          // last added _list item would have animation only not others
          if (i == _listIngredients.length - 1 && _controller.isAnimating) {
            double fromX = 0, fromY = 0;
            final height = MediaQuery.of(context).size.height;
            // first animated item & second & so on..
            if (j == 0) {
              fromX = -_pizzaConstraints.maxWidth * (1 - animation.value);
            } else if (j == 1) {
              fromX = _pizzaConstraints.maxWidth * (1 - animation.value);
            } else if (j == 2) {
              fromY = -height * (1 - animation.value);
            } else {
              fromY = height * (1 - animation.value);
            }
            if (animation.value > 0) {
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
            }
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

  void _onAccept(Ingredient ingredient) {
    _isFocus.value = false;
    Provider.of<PizzaBloc>(context, listen: false).addIngredient(ingredient);
    _buildIngredientAnimation();
    _controller.forward(from: 0.0);
  }

  bool _onWillAccept(Ingredient ingredient) {
    _isFocus.value = true;
    return Provider.of<PizzaBloc>(context, listen: false)
        .containsIngredient(ingredient);
  }

  @override
  Widget build(BuildContext context) {
    final _total = Provider.of<PizzaBloc>(context).total;
    return Column(
      children: [
        Expanded(
          child: DragTarget<Ingredient>(
            onAccept: (ingredient) => _onAccept(ingredient),
            onWillAccept: (ingredient) => _onWillAccept(ingredient!),
            onLeave: (ingredient) => _isFocus.value = false,
            builder: (context, candidateData, rejectedData) => LayoutBuilder(
              builder: (context, constrain) {
                _pizzaConstraints = constrain;
                return ValueListenableBuilder(
                  valueListenable: _notifierPizzaSize,
                  builder: (context, PizzaSizeState pizzaSize, _) => Stack(
                    children: [
                      Center(
                        child: ValueListenableBuilder<bool>(
                          valueListenable: _isFocus,
                          builder: (context, focused, _) {
                            return AnimatedContainer(
                              duration: _duration,
                              width: focused
                                  ? constrain.maxWidth * pizzaSize.factor - 20
                                  : constrain.maxWidth * pizzaSize.factor - 30,
                              child: Stack(
                                children: [
                                  DecoratedBox(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 15,
                                          spreadRadius: 3,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child:
                                        Image.asset('assets/pizza_/dish.png'),
                                  ),
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
                      _buiildIngredientAndDelete(),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 5),
        // Price
        AnimatedSwitcher(
          duration: _duration,
          transitionBuilder: (child, animation) {
            return SlideTransition(
                position: animation.drive(Tween<Offset>(
                    begin: const Offset(0, 0),
                    end: Offset(0, animation.value))),
                child: child);
          },
          child: Text(
            '\$$_total',
            key: UniqueKey(),
            style: const TextStyle(fontSize: 30, color: Colors.brown),
          ),
        ),
        const SizedBox(height: 10),
        // Pizza Size
        ValueListenableBuilder(
          valueListenable: _notifierPizzaSize,
          builder: (context, PizzaSizeState pizzaSize, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PizzaSizedButton(
                  text: 'S',
                  selected: pizzaSize.value == PizzaSizeValue.S,
                  onTap: () {
                    _notifierPizzaSize.value =
                        PizzaSizeState(value: PizzaSizeValue.S);
                  },
                ),
                PizzaSizedButton(
                  text: 'M',
                  selected: pizzaSize.value == PizzaSizeValue.M,
                  onTap: () {
                    _notifierPizzaSize.value =
                        PizzaSizeState(value: PizzaSizeValue.M);
                  },
                ),
                PizzaSizedButton(
                  text: 'L',
                  selected: pizzaSize.value == PizzaSizeValue.L,
                  onTap: () {
                    _notifierPizzaSize.value =
                        PizzaSizeState(value: PizzaSizeValue.L);
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buiildIngredientAndDelete() {
    final _delIngre = Provider.of<PizzaBloc>(context).deleteIngredient;
    if (_delIngre.isNotEmpty) {
      _refresh(_delIngre[0]);
    }
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return _buildIngredientsWidget(_delIngre);
      },
    );
  }

  Future<void> _refresh(Ingredient ingredient) async {
    await _controller.reverse(from: 1);
    Provider.of<PizzaBloc>(context, listen: false)
        .refreshIngredientList(ingredient);
  }
}

class PizzaSizedButton extends StatelessWidget {
  const PizzaSizedButton(
      {Key? key,
      required this.text,
      required this.selected,
      required this.onTap})
      : super(key: key);
  final String text;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? Colors.white : Colors.white.withOpacity(0.4),
          boxShadow: selected
              ? [
                  const BoxShadow(
                    spreadRadius: 2.0,
                    color: Colors.black12,
                    offset: Offset(0, 4),
                    blurRadius: 10,
                  ),
                ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(text),
        ),
      ),
    );
  }
}
