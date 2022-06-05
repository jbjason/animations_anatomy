class SyncCategory {
  final String name;
  final List<SyncProduct> products;

  const SyncCategory({required this.name, required this.products});
}

class SyncProduct {
  final String title, details, image;
  final double price;

  const SyncProduct(
      {required this.title,
      required this.details,
      required this.image,
      required this.price});
}

List<SyncCategory> syncCategories = [
  const SyncCategory(
    name: 'Order Again',
    products: [
      SyncProduct(
        title: 'ATCOASTAL',
        image: 'assets/card_/6.jpg',
        details: 'La Cresenta-Montrose, CA91020 Glendale',
        price: 450,
      ),
      SyncProduct(
        title: 'Kim Wexler',
        image: 'assets/card_/7.jpg',
        details:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        price: 450,
      ),
      SyncProduct(
        title: 'Michael Scoffield',
        image: 'assets/card_/8.jpg',
        details:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        price: 500,
      ),
    ],
  ),
  const SyncCategory(
    name: 'Favorites',
    products: [
      SyncProduct(
        title: 'SYRACUSEL',
        image: 'assets/card_/1.jpg',
        details: 'La Cresenta-Montrose, CA91020 Glendale',
        price: 240,
      ),
      SyncProduct(
        title: 'Daniel Kraig',
        image: 'assets/card_/2.jpg',
        details:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        price: 450,
      ),
      SyncProduct(
        title: 'Amanda Linn',
        image: 'assets/card_/3.jpg',
        details:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        price: 450,
      ),
    ],
  ),
  const SyncCategory(
    name: 'Starters',
    products: [
      SyncProduct(
        title: 'OCEANIC',
        image: 'assets/card_/4.jpg',
        details: 'La Cresenta-Montrose, CA91020 Glendale',
        price: 240,
      ),
      SyncProduct(
        title: 'Amanda Linn2',
        image: 'assets/card_/5.jpg',
        details:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        price: 450,
      ),
      SyncProduct(
        title: 'Daniel Kraig2',
        image: 'assets/card_/6.jpg',
        details:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        price: 750,
      ),
    ],
  ),
  const SyncCategory(
    name: 'Siders',
    products: [
      SyncProduct(
        title: 'MOUNTAINOUS',
        image: 'assets/card_/10.jpg',
        details: 'La Cresenta-Montrose, CA91020 Glendale',
        price: 240,
      ),
      SyncProduct(
        title: 'Kim Wexler2',
        image: 'assets/card_/11.jpg',
        details:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        price: 450,
      ),
      SyncProduct(
        title: 'Michael Scoffield2',
        image: 'assets/card_/12.jpg',
        details:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        price: 750,
      ),
    ],
  ),
  const SyncCategory(
    name: 'Picker For U',
    products: [
      SyncProduct(
        title: 'NEW YORK',
        image: 'assets/card_/13.jpg',
        details: 'La Cresenta-Montrose, CA91020 Glendale',
        price: 240,
      ),
      SyncProduct(
        title: 'Daniel Kraig1',
        image: 'assets/card_/14.jpg',
        details:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        price: 450,
      ),
      SyncProduct(
        title: 'Amanda Linn1',
        image: 'assets/card_/15.png',
        details:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        price: 750,
      ),
    ],
  ),
  const SyncCategory(
    name: 'Sheff\'s Choice',
    products: [
      SyncProduct(
        title: 'PARIS',
        image: 'assets/card_/16.jpg',
        details: 'La Cresenta-Montrose, CA91020 Glendale',
        price: 240,
      ),
      SyncProduct(
        title: 'Kim Wexler1',
        image: 'assets/card_/17.jpg',
        details:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        price: 450,
      ),
      SyncProduct(
        title: 'Michael Scoffield1',
        image: 'assets/card_/18.jpg',
        details:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        price: 750,
      ),
    ],
  ),
];
