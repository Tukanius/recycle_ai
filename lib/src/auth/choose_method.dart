import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_bin_flutter/components/custom_button/custom_button.dart';
import 'package:smart_bin_flutter/src/auth/login_page.dart';
import 'package:smart_bin_flutter/src/auth/register_page.dart';
import 'package:smart_bin_flutter/widget/ui/color.dart';

class ChooseMethod extends StatefulWidget {
  static const routeName = "ChooseMethod";
  const ChooseMethod({super.key});

  @override
  State<ChooseMethod> createState() => _ChooseMethodState();
}

class _ChooseMethodState extends State<ChooseMethod> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/dahivar/recycle.svg'),
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  onClick: () {
                    Navigator.of(context).pushNamed(LoginPage.routeName);
                  },
                  buttonColor: buttongreen,
                  labelText: 'Нэвтрэх',
                  textColor: white,
                  isLoading: false,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  onClick: () {
                    Navigator.of(context).pushNamed(RegisterPage.routeName);
                  },
                  buttonColor: greytext,
                  labelText: 'Бүртгүүлэх',
                  textColor: black,
                  isLoading: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
