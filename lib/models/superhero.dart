class Superhero {
  const Superhero(
      {required this.name,
      required this.description,
      required this.heroName,
      required this.pathImage,
      required this.movies,
      required this.rawColor});

  final String name;
  final String heroName;
  final String description;
  final String pathImage;
  final List<HeroMovie> movies;
  final int rawColor;

  static const marvelHeroes = [
    Superhero(
      heroName: 'Spider\nMan',
      name: 'Peter Parker',
      description:
          'Spider-Man has spider-like abilities including superhuman streng'
          'th and the ability to cling to most surfaces. '
          'He is also extremely agile and has amazing reflexes. Spider-Man'
          ' also has a “spider sense,” that warns him of '
          'impending danger. Spider-Man has supplemented his powers with t'
          'echnology',
      pathImage: 'assets/superhero_/spiderman-a.png',
      movies: HeroMovie.spidermanMovies,
      rawColor: 0xffA41209,
    ),
    Superhero(
      heroName: 'Iron\nMan',
      name: 'Tony Stark',
      description:
          'He is the Armored Avenger - driven by a heart that is part machin'
          'e, but all hero! He is the '
          "INVINCIBLE IRON MAN! Iron Man's Powers and Abilities: Wears modu"
          'lar arc reactor-powered Iron Man armor, '
          'granting superhuman strength & durability, the ability to fly &'
          ' project Repulsor blasts',
      pathImage: 'assets/superhero_/ironman-a.png',
      movies: HeroMovie.ironManMovies,
      rawColor: 0xffB3790F,
    ),
    Superhero(
      heroName: 'Thor',
      name: 'Thor Odinson',
      description:
          'Thor Odinson is the Asgardian God of Thunder, superhero, self-pro'
          'claimed protector of Earth and the king of '
          'Asgard. Thor made a name for himself as the mightiest warrior on '
          'his homeworld and subsequently became well '
          'known for his actions on Earth, which included acting as a found'
          'ing member of the Avengers.',
      pathImage: 'assets/superhero_/thor-c.png',
      movies: HeroMovie.thorMovies,
      rawColor: 0xff3E4953,
    ),
    Superhero(
      heroName: 'Ant\nMan',
      name: 'Scott Lang',
      description:
          'Armed with the astonishing ability to shrink in scale but increas'
          'e in strength, con-man Scott Lang must embrace '
          'his inner-hero and help his mentor, Dr. Hank Pym, protect the se'
          'cret behind his spectacular Ant-Man suit '
          'from a new generation of towering threats.',
      pathImage: 'assets/superhero_/antman-a.png',
      movies: HeroMovie.antmanMovies,
      rawColor: 0xff98142B,
    ),
    Superhero(
      heroName: 'Black\nWidow',
      name: 'Natasha Romanova',
      description:
          'The first and best-known Black Widow is a Russian agent trained'
          ' as a spy, martial artist, and sniper, '
          'and outfitted with an arsenal of high-tech weaponry, including a'
          ' pair of wrist-mounted energy weapons '
          'dubbed her "Widow\'s Bite". She wears no costume during her firs'
          't few appearances but simply evening wear and a veil.',
      pathImage: 'assets/superhero_/blackwidow-a.png',
      movies: HeroMovie.blackWidowMovies,
      rawColor: 0xff011535,
    ),
    Superhero(
      heroName: 'Captain\nAmerica',
      name: 'Steve Rogers',
      description:
          'Captain America is the alter ego of Steve Rogers, a frail young '
          'man enhanced to the peak of human perfection '
          "by an experimental serum to aid the United States government's"
          ' efforts in World War II. Near the end of the war, '
          'he was trapped in ice and survived in suspended animation until'
          ' he was revived in modern times.',
      pathImage: 'assets/superhero_/captain-b.png',
      movies: HeroMovie.captainAmericaMovies,
      rawColor: 0xff0232CB,
    ),
    Superhero(
      heroName: 'Hawk\neye',
      name: 'Clint Barton',
      description:
          'An expert marksman and fighter, Clint Barton puts his talents to '
          'good use by working for S.H.I.E.L.D.'
          ' as a special agent. The archer known as Hawkeye also boasts a '
          'strong moral compass that at times leads '
          'him astray from his direct orders',
      pathImage: 'assets/superhero_/hawkeye.png',
      movies: [],
      rawColor: 0xff380142,
    ),
    Superhero(
      heroName: 'Hulk',
      name: 'Bruce Banner',
      description:
          'In his comic book appearances, the character is both the Hulk, a '
          'green-skinned, hulking and muscular '
          'humanoid possessing a vast degree of physical strength, and his '
          'alter ego Dr. Robert Bruce Banner, a '
          'physically weak, socially withdrawn, and emotionally reserved '
          'physicist',
      pathImage: 'assets/superhero_/hulk-b.png',
      movies: HeroMovie.hulkMovies,
      rawColor: 0xff047A3B,
    ),
    Superhero(
      heroName: '12',
      name: 'Bruce Banner',
      description: '',
      pathImage: 'assets/superhero_/hulk-b.png',
      movies: [],
      rawColor: 0xFFFFFFFF,
    ),
  ];
}

class HeroMovie {
  const HeroMovie(
    this.title,
    this.rate,
    this.urlImage,
  );

  final String title;
  final double rate;
  final String urlImage;

  static const antmanMovies = [
    HeroMovie(
      'Ant-Man',
      7.6,
      "assets/card_/12.jpg",
    ),
    HeroMovie(
      'Ant-Man and the Wasp',
      8.2,
      "assets/card_/10.jpg",
    ),
    HeroMovie(
      "Black Widow",
      10,
      "assets/card_/11.jpg",
    )
  ];
  static const blackWidowMovies = [
    HeroMovie(
      'Ant-Man1',
      7.6,
      "assets/card_/1.jpg",
    ),
    HeroMovie(
      'Ant-Man and the Wasp1',
      8.2,
      "assets/card_/2.jpg",
    ),
    HeroMovie(
      "Black Widow1",
      10,
      "assets/card_/3.jpg",
    )
  ];
  static const captainAmericaMovies = [
    HeroMovie(
      'Ant-Man',
      7.6,
      "assets/card_/4.jpg",
    ),
    HeroMovie(
      'Ant-Man and the Wasp',
      8.2,
      "assets/card_/5.jpg",
    ),
    HeroMovie(
      "Black Widow",
      10,
      "assets/card_/6.jpg",
    )
  ];
  static const hulkMovies = [
    HeroMovie(
      'Ant-Man2',
      7.6,
      "assets/card_/7.jpg",
    ),
    HeroMovie(
      'Ant-Man and the Wasp2',
      8.2,
      "assets/card_/8.jpg",
    ),
    HeroMovie(
      "Black Widow2",
      10,
      "assets/card_/9.jpg",
    )
  ];
  static const ironManMovies = [
    HeroMovie(
      'Ant-Man3',
      7.6,
      "assets/card_/13.jpg",
    ),
    HeroMovie(
      'Ant-Man and the Wasp3',
      8.2,
      "assets/card_/14.jpg",
    ),
    HeroMovie(
      "Black Widow3",
      10,
      "assets/card_/15.png",
    )
  ];
  static const spidermanMovies = [
    HeroMovie(
      'Ant-Man4',
      7.6,
      "assets/card_/16.jpg",
    ),
    HeroMovie(
      'Ant-Man and the Wasp4',
      8.2,
      "assets/card_/17.jpg",
    ),
    HeroMovie(
      "Black Widow4",
      10,
      "assets/card_/18.jpg",
    )
  ];
  static const thorMovies = [
    HeroMovie(
      'Ant-Man6',
      7.6,
      "assets/card_/3.jpg",
    ),
    HeroMovie(
      'Ant-Man and the Wasp6',
      8.2,
      "assets/card_/10.jpg",
    ),
    HeroMovie(
      "Black Widow6",
      10,
      "assets/card_/6.jpg",
    )
  ];
}
