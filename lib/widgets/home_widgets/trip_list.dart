import 'package:animations_anatomy/models/trip.dart';
import 'package:animations_anatomy/screens/details_screen.dart';
import 'package:flutter/material.dart';

class TripList extends StatefulWidget {
  const TripList({Key? key}) : super(key: key);

  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  final List<Widget> _tripTiles = [];
  final GlobalKey _listKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _addTrips();
  }

  void _addTrips() {
    List<Trip> _trips = [
      const Trip(
          title: 'Beach Paradise', price: '350', nights: '3', img: 'beach.png'),
      const Trip(
          title: 'City Break', price: '400', nights: '5', img: 'city.png'),
      const Trip(
          title: 'Ski Adventure', price: '750', nights: '2', img: 'ski.png'),
      const Trip(
          title: 'Space Blast', price: '600', nights: '4', img: 'space.png'),
    ];

    for (var trip in _trips) {
      _tripTiles.add(_buildTile(trip));
    }
  }

  Widget _buildTile(Trip trip) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return Details(trip: trip, animation: animation);
            },
            transitionDuration: const Duration(seconds: 1),
          ),
        );
      },
      contentPadding: const EdgeInsets.all(25),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${trip.nights} nights',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[300])),
          Text(trip.title,
              style: TextStyle(fontSize: 20, color: Colors.grey[600])),
        ],
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          'assets/${trip.img}',
          height: 50.0,
        ),
      ),
      trailing: Text('\$${trip.price}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        key: _listKey,
        itemCount: _tripTiles.length,
        itemBuilder: (context, index) {
          return _tripTiles[index];
        });
  }
}
