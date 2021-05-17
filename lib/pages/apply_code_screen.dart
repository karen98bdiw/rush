import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rush/api/rush_api.dart';
import 'package:rush/models/custom_user.dart';
import 'package:rush/utils/colors.dart';
import 'package:rush/utils/diologs.dart';
import 'package:rush/widgets/app_inScreen_logo.dart';
import 'package:rush/widgets/custom_button.dart';
import 'package:rush/widgets/form_input.dart';

class ApplyCodeScreen extends StatefulWidget {
  final String token;
  final CustomUser user;

  ApplyCodeScreen({this.token, this.user});

  static final routeName = "ApplyCodeScreen";

  @override
  _ApplyCodeScreenState createState() => _ApplyCodeScreenState();
}

class _ApplyCodeScreenState extends State<ApplyCodeScreen> {
  String code;

  Future<bool> onApply() async {
    print(code);
    var res = await RushApi().userServices.verifyEmail(
          code: code,
          email: widget.user.email,
          token: widget.token,
        );
        
    if (res.done && res.succses) {
      return true;
    }

    showError(errorText: res.error.errorText);
  }

  @override
  Widget build(BuildContext context) {
    print("token from apply screeen ${widget.token}");
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (c, cn) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: cn.maxHeight,
                minWidth: cn.maxWidth,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 43,
                  left: 30,
                  right: 30,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AppInScreenLogo(
                      parentContstaits: cn,
                    ),
                    Text(
                      "Please enter the 4 digit code sent to your your email",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: PinCodeTextField(
                        textInputType: TextInputType.number,
                        backgroundColor: Colors.transparent,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        length: 4,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          activeColor: AppColors.Main_Orange,
                          inactiveColor: Colors.grey,
                          inactiveFillColor: Colors.grey[200],
                          selectedColor: AppColors.Main_Orange,
                          selectedFillColor: AppColors.Main_Orange,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.zero,
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                        ),
                        animationDuration: Duration(milliseconds: 300),
                        enableActiveFill: true,
                        onCompleted: (v) {},
                        onChanged: (value) {
                          code = value;
                        },
                        beforeTextPaste: (text) {
                          return true;
                        },
                      ),
                    ),
                    CustomButton(
                      title: "Apply",
                      onClick: onApply,
                      fillColor: AppColors.Main_Orange,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
