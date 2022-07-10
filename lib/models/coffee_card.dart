class CoffeeCard {
  const CoffeeCard({
    required this.image,
    required this.name,
    required this.price,
  });
  final String image, name;
  final double price;
}

const List<CoffeeCard> coffeeCards = [
  CoffeeCard(
      image: 'assets/coffee_/7.png', name: 'Caramel Macchiato', price: 4.20),
  CoffeeCard(
      image: 'assets/coffee_/2.png', name: 'Caramel Cold Drink', price: 4.50),
  CoffeeCard(
      image: 'assets/coffee_/3.png', name: 'Iced Coffe Mocha', price: 3.0),
  CoffeeCard(
      image: 'assets/coffee_/4.png',
      name: 'Caramelized Pecan Latte',
      price: 3.50),
  CoffeeCard(
      image: 'assets/coffee_/5.png', name: 'Toffee Nut Latte', price: 5.20),
  CoffeeCard(image: 'assets/coffee_/6.png', name: 'Capuchino', price: 8.0),
  CoffeeCard(
      image: 'assets/coffee_/1.png', name: 'Toffee Nut Iced Latte', price: 9.0),
  CoffeeCard(image: 'assets/coffee_/8.png', name: 'Americano', price: 5.5),
  CoffeeCard(
      image: 'assets/coffee_/9.png',
      name: 'Vietnamese-Style Iced Coffee',
      price: 8.2),
  CoffeeCard(
      image: 'assets/coffee_/10.png', name: 'Black Tea Latte', price: 4.5),
  CoffeeCard(
      image: 'assets/coffee_/11.png', name: 'Classic Irish Coffee', price: 6.6),
  CoffeeCard(
      image: 'assets/coffee_/12.png',
      name: 'Toffee Nut Crunch Latte',
      price: 7.77),
];
