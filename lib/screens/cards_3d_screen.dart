import 'package:animations_anatomy/models/book.dart';
import 'package:flutter/material.dart';

class Cards3dScreen extends StatefulWidget {
  const Cards3dScreen({Key? key}) : super(key: key);
  @override
  State<Cards3dScreen> createState() => _Cards3dScreenState();
}

class _Cards3dScreenState extends State<Cards3dScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('My Playlist'),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Expanded(flex: 3, child: Cards3dBody()),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    const Text('Recently Played'),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: books.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Cards3dItem(card: books[index]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Cards3dBody extends StatefulWidget {
  const Cards3dBody({Key? key}) : super(key: key);
  @override
  State<Cards3dBody> createState() => _Cards3dBodyState();
}

class _Cards3dBodyState extends State<Cards3dBody> {
  double value = 0.0;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth * .5,
          color: Colors.deepPurple,
          child: Stack(
            children: [
              ...List.generate(
                books.length,
                (index) => Cards3dItem(card: books[index]),
              ).reversed,
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Slider(
                    value: value,
                    onChanged: (val) => setState(() => value = val)),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Cards3dItem extends StatelessWidget {
  const Cards3dItem({Key? key, required this.card}) : super(key: key);
  final Book card;
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      elevation: 10,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image:
              DecorationImage(image: AssetImage(card.image), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
