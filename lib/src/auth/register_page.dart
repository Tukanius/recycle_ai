import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:smart_bin_flutter/components/custom_button/custom_button.dart';
import 'package:smart_bin_flutter/models/user.dart';
import 'package:smart_bin_flutter/provider/user_provider.dart';
import 'package:smart_bin_flutter/src/auth/login_page.dart';
import 'package:smart_bin_flutter/src/auth/opt_page.dart';
import 'package:smart_bin_flutter/widget/ui/color.dart';
import 'package:smart_bin_flutter/widget/ui/form_textfield.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = "RegisterPage";
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  bool isLoading = false;
  onSubmit() async {
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isLoading = true;
        });
        User save = User.fromJson(fbkey.currentState!.value);
        await Provider.of<UserProvider>(context, listen: false).register(save);
        await Navigator.of(context).pushNamed(OtpPage.routeName,
            arguments: OtpPageArguments(username: save.username));
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
              'Бүртгүүлэх',
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
              child: FormTextField(
                labelText: 'Утасны дугаар',
                color: greytext,
                name: "username",
                hintText: 'Утасны дугаар',
                colortext: black,
                validators: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Нууц үгээ оруулна уу.')
                ]),
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
              labelText: 'Бүртгүүлэх',
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
                  "Already have an account?",
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
                    Navigator.of(context).pushNamed(LoginPage.routeName);
                  },
                  child: Text(
                    "Login",
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
