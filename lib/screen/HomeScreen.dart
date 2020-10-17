import 'package:flutter/material.dart';

import 'package:tsa_gram/common/Layout.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
        child: Column(
      children: [
        Text('coucou light',
            style: Theme.of(context)
                .primaryTextTheme
                .bodyText2
                .copyWith(fontSize: 50)),
        Text('coucou regular',
            style: Theme.of(context)
                .primaryTextTheme
                .bodyText1
                .copyWith(fontSize: 50)),
        Text('coucou bold',
            style: Theme.of(context)
                .primaryTextTheme
                .headline1
                .copyWith(fontSize: 50))
      ],
    ));
  }
}
