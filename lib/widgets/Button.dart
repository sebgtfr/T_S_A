import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({
    @required this.onSubmit,
    @optionalTypeArgs this.label,
    @optionalTypeArgs this.onValidate,
  });

  final Future<dynamic> Function() onSubmit;

  final String label;
  final bool Function() onValidate;

  @override
  Widget build(BuildContext context) {
    print(this.label);
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(
          color: Color(0xFF4C5359),
        ),
      ),
      elevation: 1,
      minWidth: double.maxFinite,
      height: 50,
      color: Color(0xFFE0F4FB),
      onPressed: () {
        if (this.onValidate == null || this.onValidate()) {
          this.onSubmit()?.catchError((dynamic e) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(e.message),
                backgroundColor: Colors.redAccent,
              ),
            );
          });
        }
      },
      child: Text(
        this.label ?? 'Send',
        style: Theme.of(context).primaryTextTheme.headline1.copyWith(
              fontSize: 16,
            ),
      ),
    );
  }
}
