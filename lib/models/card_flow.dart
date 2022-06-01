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
  const CardFlow(
      title: 'ATCOASTAL',
      image: 'assets/card_/7.jpg',
      details: 'La Cresenta-Montrose, CA91020 Glendale',
      date: '6/05/2022',
      price: '450USD',
      reviews: [
        CardReview(
          subtitle: 'We travel not to escape life...',
          date: 'AUG 15th',
          title: 'Kim Wexler',
          avatar: 'assets/card_/jb1.jpg',
          image: 'assets/card_/9.jpg',
          details:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        ),
        CardReview(
          date: 'FEB 14th',
          title: 'Michael Scoffield',
          avatar: 'assets/card_/jb.jpg',
          image: 'assets/card_/13.jpg',
          details:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
          subtitle: 'We travel not to escape life...',
        ),
      ],
      place: 'Empire Tower'),
  const CardFlow(
      title: 'SYRACUSE',
      image: 'assets/card_/4.jpg',
      details: 'La Cresenta-Montrose, CA91020 Glendale',
      date: '6/05/2022',
      price: '440USD',
      reviews: [
        CardReview(
          date: 'JAN 24th',
          title: 'Daniel Kraig',
          image: 'assets/card_/12.jpg',
          avatar: 'assets/card_/jb1.jpg',
          subtitle: 'We travel not to escape life...',
          details:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        ),
        CardReview(
          subtitle: 'We travel not to escape life...',
          date: 'MAR 18th',
          title: 'Amanda Linn',
          avatar: 'assets/card_/jb.jpg',
          image: 'assets/card_/10.jpg',
          details:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        ),
      ],
      place: 'The Eifel Tower'),
  const CardFlow(
      title: 'OCEANIC',
      image: 'assets/card_/3.jpg',
      details: 'La Cresenta-Montrose, CA91020 Glendale',
      date: '6/05/2022',
      price: '705USD',
      reviews: [
        CardReview(
          subtitle: 'We travel not to escape life...',
          date: 'MAR 18th',
          title: 'Amanda Linn2',
          avatar: 'assets/card_/jb.jpg',
          image: 'assets/card_/7.jpg',
          details:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        ),
        CardReview(
          date: 'JAN 24th',
          title: 'Daniel Kraig2',
          image: 'assets/card_/8.jpg',
          avatar: 'assets/card_/jb1.jpg',
          subtitle: 'We travel not to escape life...',
          details:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        ),
      ],
      place: 'London State'),
  const CardFlow(
      title: 'MOUNTAINOUS',
      image: 'assets/card_/5.jpg',
      details: 'La Cresenta-Montrose, CA91020 Glendale',
      date: '6/05/2022',
      price: '890USD',
      reviews: [
        CardReview(
          subtitle: 'We travel not to escape life...',
          date: 'AUG 15th',
          title: 'Kim Wexler2',
          avatar: 'assets/card_/jb1.jpg',
          image: 'assets/card_/9.jpg',
          details:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        ),
        CardReview(
          date: 'FEB 14th',
          title: 'Michael Scoffield2',
          avatar: 'assets/card_/jb.jpg',
          image: 'assets/card_/13.jpg',
          details:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
          subtitle: 'We travel not to escape life...',
        ),
      ],
      place: 'Los Angelas'),
  const CardFlow(
      title: 'NEW YORK',
      image: 'assets/card_/1.jpg',
      details: 'La Cresenta-Montrose, CA91020 Glendale',
      date: '6/05/2022',
      price: '890USD',
      reviews: [
        CardReview(
          date: 'JAN 24th',
          title: 'Daniel Kraig1',
          image: 'assets/card_/12.jpg',
          avatar: 'assets/card_/jb1.jpg',
          subtitle: 'We travel not to escape life...',
          details:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        ),
        CardReview(
          subtitle: 'We travel not to escape life...',
          date: 'MAR 18th',
          title: 'Amanda Linn1',
          avatar: 'assets/card_/jb.jpg',
          image: 'assets/card_/10.jpg',
          details:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        ),
      ],
      place: 'Manhattan'),
  const CardFlow(
      title: 'PARIS',
      image: 'assets/card_/6.jpg',
      details: 'La Cresenta-Montrose, CA91020 Glendale',
      date: '6/05/2022',
      price: '890USD',
      reviews: [
        CardReview(
          subtitle: 'We travel not to escape life...',
          date: 'AUG 15th',
          title: 'Kim Wexler1',
          avatar: 'assets/card_/jb1.jpg',
          image: 'assets/card_/9.jpg',
          details:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        ),
        CardReview(
          date: 'FEB 14th',
          title: 'Michael Scoffield1',
          avatar: 'assets/card_/jb.jpg',
          image: 'assets/card_/13.jpg',
          details:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
          subtitle: 'We travel not to escape life...',
        ),
      ],
      place: 'Man City'),
];
