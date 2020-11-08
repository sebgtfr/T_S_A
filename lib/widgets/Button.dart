import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    @required this.onSubmit,
    @optionalTypeArgs this.label,
    @optionalTypeArgs this.onValidate,
  });

  final Future<dynamic> Function() onSubmit;

  final String label;
  final bool Function() onValidate;

  @override
  Widget build(BuildContext context) {
    print(label);
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: const BorderSide(
          color: Color(0xFF4C5359),
        ),
      ),
      elevation: 1,
      minWidth: double.maxFinite,
      height: 50,
      color: const Color(0xFFE0F4FB),
      onPressed: () {
        if (onValidate == null || onValidate()) {
          onSubmit()?.catchError((dynamic e) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(e.message as String),
                backgroundColor: Colors.redAccent,
              ),
            );
          });
        }
      },
      child: Text(
        label ?? 'Send',
        style: Theme.of(context).primaryTextTheme.headline1.copyWith(
              fontSize: 16,
            ),
      ),
    );
  }
}
