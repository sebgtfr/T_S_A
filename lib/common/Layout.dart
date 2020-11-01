import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  const Layout({
    Key key,
    @required this.child,
    @optionalTypeArgs this.appBar,
    @optionalTypeArgs this.floatingActionButton,
  }) : super(key: key);

  final Widget child;
  final AppBar appBar;
  final FloatingActionButton floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return _Layout(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      child: child,
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout({
    Key key,
    @required this.child,
    @optionalTypeArgs this.appBar,
    @optionalTypeArgs this.floatingActionButton,
  }) : super(key: key);

  final Widget child;
  final AppBar appBar;
  final FloatingActionButton floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: SafeArea(child: child),
    );
  }
}
