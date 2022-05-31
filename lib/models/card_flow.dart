class CardFlow {
  final String title, details, date, image;
  final String price, place;
  final List<CardReview> reviews;
  const CardFlow({
    required this.place,
    required this.title,
    required this.details,
    required this.date,
    required this.image,
    required this.price,
    required this.reviews,
  });
}

class CardReview {
  final String avatar, title, subtitle, details, image;
  final String date;
  const CardReview(
      {required this.avatar,
      required this.title,
      required this.subtitle,
      required this.details,
      required this.image,
      required this.date});
}

final List<CardFlow> cardFlows = [
  CardFlow(
      title: 'ATCOASTAL',
      image: 'assets/card_/1.jpg',
      details: 'La Cresenta-Montrose, CA91020 Glendale',
      date: '6/05/2022',
      price: '450USD',
      reviews: Reviews.allReviews,
      place: 'Empire Tower'),
  CardFlow(
      title: 'SYRACUSE',
      image: 'assets/card_/2.jpg',
      details: 'La Cresenta-Montrose, CA91020 Glendale',
      date: '6/05/2022',
      price: '440USD',
      reviews: Reviews.allReviews,
      place: 'The Eifel Tower'),
  CardFlow(
      title: 'OCEANIC',
      image: 'assets/card_/3.jpg',
      details: 'La Cresenta-Montrose, CA91020 Glendale',
      date: '6/05/2022',
      price: '705USD',
      reviews: Reviews.allReviews,
      place: 'London State'),
  CardFlow(
      title: 'MOUNTAINOUS',
      image: 'assets/card_/4.jpg',
      details: 'La Cresenta-Montrose, CA91020 Glendale',
      date: '6/05/2022',
      price: '890USD',
      reviews: Reviews.allReviews,
      place: 'Los Angelas'),
  CardFlow(
      title: 'NEW YORK',
      image: 'assets/card_/5.jpg',
      details: 'La Cresenta-Montrose, CA91020 Glendale',
      date: '6/05/2022',
      price: '890USD',
      reviews: Reviews.allReviews,
      place: 'Manhattan'),
  CardFlow(
      title: 'PARIS',
      image: 'assets/card_/6.jpg',
      details: 'La Cresenta-Montrose, CA91020 Glendale',
      date: '6/05/2022',
      price: '890USD',
      reviews: Reviews.allReviews,
      place: 'Man City'),
];

class Reviews {
  static List<CardReview> allReviews = [
    const CardReview(
      date: 'FEB 14th',
      title: 'Michael Scoffield',
      avatar: 'assets/jb.jpg',
      image: 'assets/13.jpg',
      details:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
      subtitle: 'We travel not to escape life...',
    ),
    const CardReview(
      date: 'JAN 24th',
      title: 'Daniel Kraig',
      image: 'assets/12.jpg',
      avatar: 'assets/jb1.jpg',
      subtitle: 'We travel not to escape life...',
      details:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
    ),
    const CardReview(
      subtitle: 'We travel not to escape life...',
      date: 'MAR 18th',
      title: 'Amanda Linn',
      avatar: 'assets/jb.jpg',
      image: 'assets/10.jpg',
      details:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
    ),
    const CardReview(
      subtitle: 'We travel not to escape life...',
      date: 'AUG 15th',
      title: 'Kim Wexler',
      avatar: 'assets/jb.jpg',
      image: 'assets/9.jpg',
      details:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
    ),
  ];
}
