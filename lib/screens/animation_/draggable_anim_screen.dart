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
          Positioned.fill(
              child: Image.asset('assets/card_/5.jpg', fit: BoxFit.cover)),
          Positioned.fill(
            bottom: 0,
            child: NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                // drag bottom to Top : value = 0 to 1
                // drag top to bottom  : value = 1 to 0
                setState(() {
                  _percent = 2 * notification.extent - 0.8;
                  print(_percent);
                });
                return true;
              },
              child: DraggableScrollableSheet(
                maxChildSize: 0.9,
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
                                return ListTile(
                                  leading:
                                      const Icon(Icons.location_on_outlined),
                                  title: Text('Heil to Jb Jason $index'),
                                  subtitle: Text('City $index'),
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
          ),
          Positioned(
            top: -size.height * .25 * (1 - _percent),
            left: 0,
            right: 0,
            height: size.height * .25,
            child: Container(
              color: Colors.deepPurple,
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Navigator.maybePop(context),
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
