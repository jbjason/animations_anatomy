class Trip {
  final String title;
  final String price;
  final String nights;
  final String img;

  const Trip(
      {required this.title,
      required this.price,
      required this.nights,
      required this.img});
}

final List<Trip> trips = [
  const Trip(
      title: 'Beach Paradise', price: '350', nights: '3', img: 'beach.png'),
  const Trip(title: 'City Break', price: '400', nights: '5', img: 'city.png'),
  const Trip(title: 'Ski Adventure', price: '750', nights: '2', img: 'ski.png'),
  const Trip(title: 'Space Blast', price: '600', nights: '4', img: 'space.png'),
  const Trip(title: 'Beach', price: '350', nights: '3', img: 'beach.png'),
  const Trip(title: 'City', price: '400', nights: '5', img: 'city.png'),
  const Trip(title: 'Ski', price: '750', nights: '2', img: 'ski.png'),
  const Trip(title: 'Space', price: '600', nights: '4', img: 'space.png'),
];

final List<Trip> trips1 = [
  const Trip(
      title: 'Beach Paradise',
      price: '350',
      nights: '3',
      img: 'assets/trip/001.png'),
  const Trip(
      title: 'Space Blast',
      price: '600',
      nights: '4',
      img: 'assets/trip/002.png'),
  const Trip(
      title: 'Beach', price: '350', nights: '3', img: 'assets/trip/003.png'),
  const Trip(
      title: 'City', price: '400', nights: '5', img: 'assets/trip/004.png'),
  const Trip(
      title: 'Ski', price: '750', nights: '2', img: 'assets/trip/005.png'),
  const Trip(
      title: 'Space', price: '600', nights: '4', img: 'assets/trip/space.png'),
];
