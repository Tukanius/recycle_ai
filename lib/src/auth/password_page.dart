import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:smart_bin_flutter/components/custom_button/custom_button.dart';
import 'package:smart_bin_flutter/models/user.dart';
import 'package:smart_bin_flutter/provider/user_provider.dart';
import 'package:smart_bin_flutter/src/auth/login_page.dart';
import 'package:smart_bin_flutter/src/main_page.dart';
import 'package:smart_bin_flutter/widget/ui/color.dart';
import 'package:smart_bin_flutter/widget/ui/form_textfield.dart';

class PassWordPageArguments {
  bool? isForgot;
  PassWordPageArguments({
    this.isForgot,
  });
}

class PassWordPage extends StatefulWidget {
  final bool? isForgot;
  static const routeName = "PassWordPage";
  const PassWordPage({super.key, this.isForgot});

  @override
  State<PassWordPage> createState() => _PassWordPageState();
}

class _PassWordPageState extends State<PassWordPage> {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  bool isVisible = true;
  bool isVisible1 = true;
  bool isLoading = false;
  onSubmit() async {
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isLoading = true;
        });
        User save = User.fromJson(fbkey.currentState!.value);
        await Provider.of<UserProvider>(context, listen: false)
            .setPassword(save);
        await Provider.of<UserProvider>(context, listen: false).me(false);
        Navigator.of(context).pushNamed(MainPage.routeName);
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
    return PopScope(
      canPop: false,
      child: Scaffold(
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
                'Баталгаажуулалт',
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
                    const SizedBox(height: 20),
                    FormTextField(
                      labelText: "Нууц үг баталгаажуулах",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible1 = !isVisible1;
                          });
                        },
                        icon: isVisible1 == false
                            ? Icon(Icons.visibility, color: colortext)
                            : Icon(Icons.visibility_off, color: colortext),
                      ),
                      inputType: TextInputType.visiblePassword,
                      color: greytext,
                      colortext: black,
                      hintText: 'Нууц үг',
                      name: "password1",
                      obscureText: isVisible1,
                      validators: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "Нууц үгээ давтан оруулна уу"),
                        (value) {
                          if (fbkey.currentState?.fields['password']?.value !=
                              value) {
                            return 'Оруулсан нууц үгтэй таарахгүй байна';
                          }
                          return null;
                        }
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
                labelText: 'Хадгалах',
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
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
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
      ),
    );
  }
}
