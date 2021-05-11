import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:rush/managment/locale.dart';
import 'package:rush/utils/colors.dart';
import 'package:rush/utils/constats.dart';
import 'package:rush/widgets/app_bar.dart';
import 'package:rush/widgets/custom_button.dart';
import 'package:rush/widgets/form_imput.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatefulWidget {
  static final routeName = "SignUpScreen";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  LocaleManagment localeManagment;
  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    localeManagment = Provider.of<LocaleManagment>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: CustomAppBar(
            title: AppLocalizations.of(context).resgistrationTitle),
        body: LayoutBuilder(
          builder: (c, cn) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: cn.maxWidth,
                minHeight: cn.maxHeight,
              ),
              child: _body(
                parentConstraits: cn,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _body({BoxConstraints parentConstraits}) => Padding(
        padding: const EdgeInsets.only(bottom: 43),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _top(parentConstraits: parentConstraits),
                _form(parentConstraits: parentConstraits),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            CustomButton(
              title: AppLocalizations.of(context).signUpButton,
              onClick: () {
                _formState.currentState.validate();
              },
            ),
          ],
        ),
      );

  Widget _top({BoxConstraints parentConstraits}) => Container(
        height: parentConstraits.maxHeight * 0.3,
        child: Stack(
          children: [
            Container(
              color: AppColors.Pink_Light,
              height: parentConstraits.maxHeight * 0.15,
            ),
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: parentConstraits.maxHeight * 0.075,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.camera_alt,
                            color: AppColors.Main_Orange,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _form({BoxConstraints parentConstraits}) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: parentConstraits.maxWidth * 0.07,
        ),
        child: Form(
          key: _formState,
          child: Column(
            children: [
              FormInput(
                hint: AppLocalizations.of(context).emailHint,
                validator: MultiValidator([
                  RequiredValidator(errorText: "E-Mail is required"),
                  PatternValidator(AppConstats.Regexp_Email,
                      errorText: "Please write valid e-mail"),
                ]),
              ),
              FormInput(
                hint: AppLocalizations.of(context).usernameHint,
                validator: RequiredValidator(errorText: "Username is required"),
              ),
              FormInput(
                controller: _passwordController,
                hint: AppLocalizations.of(context).passwordHint,
                validator: MultiValidator([
                  RequiredValidator(errorText: "Please write password"),
                  LengthRangeValidator(
                      min: 6,
                      max: 10,
                      errorText: "Password must be at last 6 characters")
                ]),
              ),
              FormInput(
                hint: "Confirm password",
                validator: (v) => v.isEmpty
                    ? "Please confirm password"
                    : v == _passwordController.text
                        ? null
                        : "Password doesn't match",
              ),
            ],
          ),
        ),
      );
}
