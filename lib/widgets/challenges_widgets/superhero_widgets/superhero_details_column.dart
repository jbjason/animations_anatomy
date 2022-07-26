import 'package:animations_anatomy/models/superhero.dart';
import 'package:flutter/material.dart';

class SuperHeroDetailsColumn extends StatelessWidget {
  const SuperHeroDetailsColumn({
    Key? key,
    required this.heroes,
    required this.animation,
    required this.index,
  }) : super(key: key);

  final List<Superhero> heroes;
  final int index;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: Offset(0, 200 * (1 - animation.value)),
            child: SizedBox(
              height: size.height * .42,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 30,
                      alignment: Alignment.centerRight,
                      child: Image.asset('assets/superhero_/marvel_logo.jpg'),
                    ),
                    const SizedBox(height: 20),
                    Container(height: 1, color: Colors.grey[300]),
                    const SizedBox(height: 20),
                    Text(
                      heroes[index].description,
                      maxLines: 4,
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    const SizedBox(height: 40),
                    const Text('movies',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      height: 200,
                      child: PageView.builder(
                        padEnds: false,
                        controller: PageController(viewportFraction: 0.4),
                        itemCount: heroes[index].movies.length,
                        itemBuilder: (context, index) {
                          final heroMovie = heroes[index].movies[index];
                          return Container(
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: AssetImage(heroMovie.urlImage),
                                  fit: BoxFit.cover),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
