import 'package:flutter/material.dart';

class DraggableAnimScreen extends StatefulWidget {
  const DraggableAnimScreen({Key? key}) : super(key: key);
  @override
  State<DraggableAnimScreen> createState() => _DraggableAnimScreenState();
}

class _DraggableAnimScreenState extends State<DraggableAnimScreen> {
  double _percent = 0.0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/card_/5.jpg'),
          Positioned.fill(
            child: DraggableScrollableSheet(
              maxChildSize: 0.8,
              minChildSize: 0.4,
              builder: (context, _controller) {
                return Material(
                  elevation: 10,
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('It\'s good to see you',
                            style: TextStyle(fontSize: 11)),
                        const Text(
                          'Where are you going ?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search_sharp,
                                color: Colors.purple[300]),
                            hintText: 'Search Destination',
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            controller: _controller,
                            itemCount: 20,
                            itemBuilder: (context, index) {
                              _percent =
                                  _controller.position.viewportDimension /
                                      size.height;
                              print(_percent);
                              return AnimatedBuilder(
                                animation: _controller,
                                builder: (context, _) {
                                  return ListTile(
                                    leading:
                                        const Icon(Icons.location_on_outlined),
                                    title: Text('Heil to Jb Jason $index'),
                                    subtitle: Text('City $index'),
                                  );
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
