// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizzle_starter/src/core/constant/sizeConfig/size_config.dart';
import 'package:sizzle_starter/src/feature/onboarding/screens/user_login_screen.dart';

class ChooseLogin extends StatelessWidget {
  const ChooseLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late ThemeData themeData;
    themeData = Theme.of(context);
    MySize().init(context);
    return Scaffold(
        body: Stack(children: <Widget>[
       ClipPath(
          clipper: _MyCustomClipper(context),
          child: Container(
            alignment: Alignment.center,
            color: themeData.colorScheme.primary,
          )),
      Column(children: <Widget>[
        SizedBox(
          height: MySize.size180,
        ),
        SizedBox(
          height: MySize.size100,
        ),
        Card(
          elevation: 0,
          color: themeData.colorScheme.surface.withAlpha(0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: <Widget>[
                    Image(
                      image:
                          AssetImage('assets/images/logo-removebg-preview.png'),
                      height: MySize.size180,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: Spacing.only(top: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        boxShadow: [
                          BoxShadow(
                            color: themeData.colorScheme.primary.withAlpha(18),
                            blurRadius: 3,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                themeData.colorScheme.primary),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    MySize.getScaledSizeHeight(
                                        8))), // Square corners
                              ),
                            ),
                          ),
                          onPressed: () {
                            context.go('/login');
                          },
                          child: Text(
                            "USER LOGIN",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.white),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        boxShadow: [
                          BoxShadow(
                            color: themeData.colorScheme.primary.withAlpha(18),
                            blurRadius: 3,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                themeData.colorScheme.primary),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    MySize.getScaledSizeHeight(
                                        8))), // Square corners
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "LAWYER LOGIN",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.white),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ])
    ]));
  }
}

class _MyCustomClipper extends CustomClipper<Path> {
  final BuildContext _context;

  _MyCustomClipper(this._context);

  @override
  Path getClip(Size size) {
    final path = Path();
    Size size = MediaQuery.of(_context).size;
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.3);
    path.lineTo(0, size.height * 0.6);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
