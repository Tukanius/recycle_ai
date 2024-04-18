import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_bin_flutter/components/custom_button/custom_button.dart';
import 'package:smart_bin_flutter/models/user.dart';
import 'package:smart_bin_flutter/provider/user_provider.dart';
import 'package:smart_bin_flutter/src/auth/register_page.dart';
import 'package:smart_bin_flutter/src/splash_screen/splash_page.dart';
import 'package:smart_bin_flutter/widget/ui/color.dart';
import 'package:smart_bin_flutter/widget/ui/form_textfield.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "LoginPage";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  bool isVisible = true;
  bool isLoading = false;
  onSubmit() async {
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isLoading = true;
        });
        User save = User.fromJson(fbkey.currentState!.value);
        await Provider.of<UserProvider>(context, listen: false).login(save);
        await Navigator.of(context).pushNamed(SplashPage.routeName);
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        print(e.toString());
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/dahivar/recycle.svg'),
            SizedBox(
              height: 10,
            ),
            Text(
              'Нэвтрэх',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: greentext,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            FormBuilder(
              key: fbkey,
              child: Column(
                children: [
                  FormTextField(
                    labelText: 'Утасны дугаар',
                    color: greytext,
                    name: "username",
                    hintText: 'Утасны дугаар',
                    colortext: black,
                    validators: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Утасны дугаар оруулна уу.')
                    ]),
                  ),
                  const SizedBox(height: 20),
                  FormTextField(
                    labelText: "Нууц үг",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: isVisible == false
                          ? Icon(Icons.visibility, color: colortext)
                          : Icon(Icons.visibility_off, color: colortext),
                    ),
                    inputType: TextInputType.visiblePassword,
                    color: greytext,
                    colortext: black,
                    hintText: 'Нууц үг',
                    name: "password",
                    obscureText: isVisible,
                    validators: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Нууц үгээ оруулна уу.')
                    ]),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              onClick: () {
                onSubmit();
              },
              buttonColor: buttongreen,
              labelText: 'Нэвтрэх',
              textColor: white,
              isLoading: isLoading,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don’t have account?",
                  style: TextStyle(
                    color: black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(RegisterPage.routeName);
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
