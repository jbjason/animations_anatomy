class Ticket {
  final String image;
  final String title;
  final String date;

  Ticket({required this.image, required this.title, required this.date});
}

final List<Ticket> tickets = [
  Ticket(
      image: 'assets/extra_/steve.jpeg',
      title: 'Shenzhen GLOBAL DESIGN AWARD 2018',
      date: '4.20-30'),
  Ticket(
      image: 'assets/extra_/efe.jpg',
      title: 'Shenzhen GLOBAL DESIGN AWARD 2018',
      date: '4.20-30'),
  Ticket(
      image: 'assets/extra_/rodion.jpeg',
      title: 'Dawan District Guangdong Hong Kong',
      date: '4.28-31'),
];
