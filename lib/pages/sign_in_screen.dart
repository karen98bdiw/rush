import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:rush/managment/locale.dart';
import 'package:rush/managment/user_managment.dart';
import 'package:rush/pages/sign_up_screen.dart';
import 'package:rush/utils/colors.dart';
import 'package:rush/utils/input_icons.dart';
import 'package:rush/widgets/custom_button.dart';
import 'package:rush/widgets/form_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInScreen extends StatefulWidget {
  static final routeName = "SignInScreen";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool wantToRemember = false;
  LocaleManagment localeManagment;

  bool _hidePassword = true;
  final FocusNode _passwordNode = FocusNode();

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  String email;
  String password;
  UserManagment userManagment = UserManagment();

  void onSignIn() {
    if (!_formState.currentState.validate()) return;
    _formState.currentState.save();
    userManagment.signIn(
      email: email,
      password: password,
    );
  }

  @override
  void initState() {
    localeManagment = Provider.of<LocaleManagment>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
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
      ),
    );
  }

  Widget _body({BoxConstraints parentConstraits}) => Padding(
        padding: const EdgeInsets.only(
          bottom: 43,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _top(parentContstaits: parentConstraits),
            _form(parentConstrints: parentConstraits),
            CustomButton(
              onClick: () {
                FocusScope.of(context).unfocus();
                onSignIn();
              },
              title: AppLocalizations.of(context).signInButton,
              fillColor: AppColors.Red_Dark,
            ),
            Text(
              AppLocalizations.of(context).forgotPass,
              style: Theme.of(context).textTheme.headline6,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(SignUpScreen.routeName);
              },
              child: Text(
                AppLocalizations.of(context).signUpButton,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ],
        ),
      );

  Widget _form({BoxConstraints parentConstrints}) => Padding(
        padding:
            EdgeInsets.symmetric(horizontal: parentConstrints.maxWidth * 0.05),
        child: Form(
          key: _formState,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormInput(
                onSaved: (v) => email = v,
                onEditingComplete: () => _passwordNode.requestFocus(),
                inputAction: TextInputAction.next,
                inputType: TextInputType.emailAddress,
                prefixIcon: InputIcons.emailPrefix,
                hint: AppLocalizations.of(context).emailHint,
                validator: RequiredValidator(errorText: "Please write E-Mail"),
              ),
              FormInput(
                onSaved: (v) => password = v,
                focusNode: _passwordNode,
                onEditingComplete: () => _passwordNode.unfocus(),
                inputAction: TextInputAction.done,
                prefixIcon: InputIcons.passwordPrefix,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                  child: InputIcons.passwordSuffix,
                ),
                validator:
                    RequiredValidator(errorText: "Please write password"),
                hint: AppLocalizations.of(context).passwordHint,
                obscureText: _hidePassword,
              ),
              SizedBox(
                height: 10,
              ),
              _confirmRemember(),
            ],
          ),
        ),
      );

  Widget _top({BoxConstraints parentContstaits}) => Image.asset(
        "assets/images/trivia_icon.png",
        height: parentContstaits.maxHeight * 0.2,
        fit: BoxFit.fitHeight,
      );
  Widget _confirmRemember() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
              activeColor: AppColors.Red_Dark,
              value: wantToRemember,
              onChanged: (v) {
                setState(() {
                  wantToRemember = !wantToRemember;
                });
              }),
          SizedBox(
            width: 10,
          ),
          Text(
            "Remember Password",
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      );
}
