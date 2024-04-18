import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_bin_flutter/provider/user_provider.dart';
import 'package:smart_bin_flutter/src/auth/choose_method.dart';
import 'package:smart_bin_flutter/src/main_page.dart';
import 'package:smart_bin_flutter/widget/ui/color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  static const routeName = "SplashPage";
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with AfterLayoutMixin {
  int isOne = 2;
  @override
  afterFirstLayout(BuildContext context) async {
    try {
      await Provider.of<UserProvider>(context, listen: false).me(false);
      Navigator.of(context).pushNamed(MainPage.routeName);
    } catch (ex) {
      debugPrint(ex.toString());
      Navigator.of(context).pushNamed(ChooseMethod.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: buttongreen,
      body: Center(
        child: SvgPicture.asset('assets/dahivar/splash.svg'),
      ),
    );
  }
}
