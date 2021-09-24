// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

enum CardType {
  standard,
  tappable,
  selectable,
}

class TravelDestination {
  const TravelDestination({
    required this.assetName,
    required this.assetPackage,
    required this.title,
    required this.description,
    required this.city,
    required this.location,
    this.cardType = CardType.standard,
  })  : assert(assetName != null),
        assert(assetPackage != null),
        assert(title != null),
        assert(description != null),
        assert(city != null),
        assert(location != null);

  final String assetName;
  final String assetPackage;
  final String title;
  final String description;
  final String city;
  final String location;
  final CardType cardType;
}

List<TravelDestination> destinations(BuildContext context) => [
  TravelDestination(
    assetName: 'assets/flutter-mark-square-64.png',
    assetPackage: 'tencent_video',
    title:
    'standard',
    description: 'THIS IS TEST',
    location: 'shanghai', city: 'fff',
  ),
  TravelDestination(
    assetName: 'assets/flutter-mark-square-64.png',
    assetPackage: 'tencent_video',
    title:
    'standard',
    description: 'THIS IS TEST',
    location: 'shanghai',
    cardType: CardType.tappable, city: '44',
  ),
  TravelDestination(
    assetName: 'assets/flutter-mark-square-64.png',
    assetPackage: 'tencent_video',
    title:
    'standard',
    description: 'THIS IS TEST',
    location: 'shanghai',
    cardType: CardType.selectable, city: 'ff',
  ),
];

class TravelDestinationItem extends StatelessWidget {
  const TravelDestinationItem({Key? key, required this.destination, this.shape})
      : assert(destination != null),
        super(key: key);

  // This height will allow for all the Card's content to fit comfortably within the card.
  static const height = 360.0;
  final TravelDestination destination;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SectionTitle(
                title:
                'sectionTitle'),
            SizedBox(
              height: height,
              child: Card(
                // This ensures that the Card's children are clipped correctly.
                clipBehavior: Clip.antiAlias,
                shape: shape,
                child: TravelDestinationContent(destination: destination),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TappableTravelDestinationItem extends StatelessWidget {
  const TappableTravelDestinationItem(
      {Key? key, required this.destination, this.shape})
      : assert(destination != null),
        super(key: key);

  // This height will allow for all the Card's content to fit comfortably within the card.
  static const height = 298.0;
  final TravelDestination destination;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SectionTitle(
                title: 'Section'),
            SizedBox(
              height: height,
              child: Card(
                // This ensures that the Card's children (including the ink splash) are clipped correctly.
                clipBehavior: Clip.antiAlias,
                shape: shape,
                child: InkWell(
                  onTap: () {},
                  // Generally, material cards use onSurface with 12% opacity for the pressed state.
                  splashColor:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                  // Generally, material cards do not have a highlight overlay.
                  highlightColor: Colors.transparent,
                  child: TravelDestinationContent(destination: destination),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectableTravelDestinationItem extends StatelessWidget {
  const SelectableTravelDestinationItem({
    Key? key,
    required this.destination,
    required this.isSelected,
    required this.onSelected,
    this.shape,
  })  : assert(destination != null),
        super(key: key);

  final TravelDestination destination;
  final ShapeBorder? shape;
  final bool isSelected;
  final VoidCallback onSelected;

  // This height will allow for all the Card's content to fit comfortably within the card.
  static const height = 298.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SectionTitle(
                title: 'sectionTitle'),
            SizedBox(
              height: height,
              child: Card(
                // This ensures that the Card's children (including the ink splash) are clipped correctly.
                clipBehavior: Clip.antiAlias,
                shape: shape,
                child: InkWell(
                  onLongPress: () {
                    onSelected();
                  },
                  // Generally, material cards use onSurface with 12% opacity for the pressed state.
                  splashColor: colorScheme.onSurface.withOpacity(0.12),
                  // Generally, material cards do not have a highlight overlay.
                  highlightColor: Colors.transparent,
                  child: Stack(
                    children: [
                      Container(
                        color: isSelected
                        // Generally, material cards use primary with 8% opacity for the selected state.
                        // See: https://material.io/design/interaction/states.html#anatomy
                            ? colorScheme.primary.withOpacity(0.5)
                            : Colors.transparent,
                      ),
                      TravelDestinationContent(destination: destination),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.check_circle,
                            color: isSelected
                                ? colorScheme.primary
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: Theme.of(context).textTheme.subtitle1),
      ),
    );
  }
}

class TravelDestinationContent extends StatelessWidget {
  const TravelDestinationContent({Key? key, required this.destination})
      : assert(destination != null),
        super(key: key);

  final TravelDestination destination;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.headline5?.copyWith(color: Colors.white);
    final descriptionStyle = theme.textTheme.subtitle1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 184,
          //color: Colors.blue,
          child: Stack(
            children: [
              Positioned.fill(
                // In order to have the ink splash appear above the image, you
                // must use Ink.image. This allows the image to be painted as
                // part of the Material and display ink effects above it. Using
                // a standard Image will obscure the ink splash.
                child: Ink.image(
                  image: AssetImage(
                    destination.assetName,
                    //package: destination.assetPackage,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    destination.title,
                    style: titleStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Description and share/explore buttons.
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: DefaultTextStyle(
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: descriptionStyle!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // This array contains the three line description on each card
                // demo.
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    destination.description,
                    style: descriptionStyle.copyWith(color: Colors.black54),
                  ),
                ),
                Text(destination.city),
                Text(destination.location),
              ],
            ),
          ),
        ),
        if (destination.cardType == CardType.standard)
        // share, explore buttons
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {},
                child: Text('AAAA',
                    semanticsLabel: 'bbbb'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('CCCC',
                    semanticsLabel: 'dddd'),
              ),
            ],
          ),
      ],
    );
  }
}

class CardsDemo extends StatefulWidget {
  const CardsDemo({Key? key}) : super(key: key);

  @override
  _CardsDemoState createState() => _CardsDemoState();
}

class _CardsDemoState extends State<CardsDemo> with RestorationMixin {
  final RestorableBool _isSelected = RestorableBool(false);

  @override
  String get restorationId => 'cards_demo';


  @override
  void dispose() {
    _isSelected.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('KFDJ'),
      ),
      body: InkWell(
        child: Container(
          width: 400,
          height: 300,
          //color: Colors.red,
          child: Image(
            image: AssetImage(
              'assets/flutter-mark-square-64.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        onLongPress: () {},
        splashColor: Colors.black,
        highlightColor: Colors.transparent,
      ),
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_isSelected, 'is_selected');
  }
}

