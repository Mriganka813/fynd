import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gofoods/custtomscreens/customtextField.dart';
import 'package:gofoods/custtomscreens/custtombutton.dart';
import 'package:gofoods/custtomscreens/textfild.dart';
import 'package:gofoods/model/input/signupinput.dart';
import 'package:gofoods/screens/authscreen/otp.dart';
import 'package:gofoods/screens/authscreen/otppage.dart';
import 'package:gofoods/screens/bottombar/bottombar.dart';
import 'package:gofoods/utils/enstring.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  final SignUpInput _signUpInput = SignUpInput();
  late ColorNotifier notifier;

  bool isChecked = false;
  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifier.setIsDark = false;
    } else {
      notifier.setIsDark = previusstate;
    }
  }

  @override
  void initState() {
    super.initState();
    getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.getbgcolor,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset("assets/signup.png"),
                  Column(
                    children: [
                      SizedBox(height: height / 12),
                      Row(
                        children: [
                          SizedBox(width: width / 20),
                          Text(
                            LanguageEn.signup,
                            style: TextStyle(
                              color: notifier.getblackcolor,
                              fontSize: height / 25,
                              fontFamily: 'GilroyBold',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height / 80),
                      Row(
                        children: [
                          SizedBox(width: width / 20),
                          Text(
                            LanguageEn.welcometogofoods,
                            style: TextStyle(
                              color: notifier.getblackcolor,
                              fontSize: height / 42,
                              fontFamily: 'GilroyMedium',
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: height / 40),
              Row(
                children: [
                  SizedBox(width: width / 20),
                  Text(
                    LanguageEn.fanme,
                    style: TextStyle(
                      color: notifier.getgrey,
                      fontSize: height / 50,
                      fontFamily: 'GilroyMedium',
                    ),
                  ),
                ],
              ),
              SizedBox(height: height / 50),
              Customtextfield(
                name: "Name",
                hintText: LanguageEn.enteryourfullname,
                textcolor: notifier.getblackcolor,
                wi: width / 1.13,
                icon: Icons.person,
                fillcolor: notifier.getbgfildcolor,
                onSave: (e) {
                  _signUpInput.name = e;
                },
              ),
              SizedBox(height: height / 40),
              Row(
                children: [
                  SizedBox(width: width / 20),
                  Text(
                    LanguageEn.emailadress,
                    style: TextStyle(
                      color: notifier.getgrey,
                      fontSize: height / 50,
                      fontFamily: 'GilroyMedium',
                    ),
                  ),
                ],
              ),
              SizedBox(height: height / 50),
              // Customtextfild.textField(
              //     LanguageEn.enteryouremail,
              //     notifier.getblackcolor,
              //     width / 1.13,
              //     Icons.email,
              //     notifier.getbgfildcolor),
              Customtextfield(
                name: LanguageEn.enteryouremail,
                textcolor: notifier.getblackcolor,
                wi: width / 1.13,
                icon: Icons.email,
                fillcolor: notifier.getbgfildcolor,
                hintText: LanguageEn.enteryouremail,
                onSave: (e) {
                  _signUpInput.email = e;
                },
              ),
              SizedBox(height: height / 40),
              Row(
                children: [
                  SizedBox(width: width / 20),
                  Text(
                    LanguageEn.phonenumbers,
                    style: TextStyle(
                      color: notifier.getgrey,
                      fontSize: height / 50,
                      fontFamily: 'GilroyMedium',
                    ),
                  ),
                ],
              ),
              SizedBox(height: height / 50),
              Customtextfield(
                name: "Phone number",
                hintText: LanguageEn.enteryourphonenumber,
                textcolor: notifier.getblackcolor,
                wi: width / 1.13,
                icon: Icons.call,
                fillcolor: notifier.getbgfildcolor,
                onSave: (e) {
                  _signUpInput.phoneNumber = e;
                },
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
                inputType: TextInputType.phone,
                validator: (e) {
                  if (_signUpInput.phoneNumber!.length < 10) {
                    return "Phone number contains 10-digit";
                  }
                  return null;
                },
              ),
              SizedBox(height: height / 40),
              Row(
                children: [
                  SizedBox(width: width / 20),
                  Text(
                    LanguageEn.password,
                    style: TextStyle(
                      color: notifier.getgrey,
                      fontSize: height / 50,
                      fontFamily: 'GilroyMedium',
                    ),
                  ),
                ],
              ),
              SizedBox(height: height / 50),
              Customtextfield(
                name: "Password",
                hintText: LanguageEn.enteryourpassword,
                textcolor: notifier.getblackcolor,
                wi: width / 1.13,
                icon: Icons.lock,
                fillcolor: notifier.getbgfildcolor,
                validator: (e) {
                  if (_signUpInput.password!.length < 8) {
                    return "Password contain minimum 8 character";
                  }
                  return null;
                },
                onSave: (e) {
                  _signUpInput.password = e;
                },
              ),
              SizedBox(height: height / 15),
              GestureDetector(
                onTap: () {
                  _formKey.currentState?.save();
                  final isValid = _formKey.currentState?.validate() ?? false;
                  // print(isValid);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const BottomHome(),
                  // ),
                  // );
                  if (isValid) _showMyDialog();
                },
                child: button(
                  notifier.getred,
                  notifier.getwhite,
                  LanguageEn.createaccount,
                  width / 1.1,
                ),
              ),
              SizedBox(height: height / 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LanguageEn.alredyhaveaccount,
                    style: TextStyle(
                      color: notifier.getgrey,
                      fontFamily: 'GilroyMedium',
                      fontSize: height / 55,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      LanguageEn.signin,
                      style: TextStyle(
                        color: const Color(0xff3a71d5),
                        fontFamily: 'GilroyMedium',
                        fontSize: height / 55,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _showMyDialog() async {
    print(_signUpInput.toMap());
    return showDialog(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: notifier.getwhite,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                color: Colors.transparent,
                height: height / 3.6,
                child: Column(
                  children: [
                    SizedBox(height: height / 130),
                    Text(
                      LanguageEn.signupwithphonenumber,
                      style: TextStyle(
                        color: notifier.getgrey,
                        fontSize: height / 60,
                        fontFamily: 'GilroyMedium',
                      ),
                    ),
                    SizedBox(height: height / 60),
                    Text(
                      _signUpInput.phoneNumber!,
                      style: TextStyle(
                        color: notifier.getblackcolor,
                        fontSize: height / 30,
                        fontFamily: 'GilroyBold',
                      ),
                    ),
                    SizedBox(height: height / 50),
                    Text(
                      LanguageEn.wewillsend,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: notifier.getgrey,
                        fontSize: height / 60,
                        fontFamily: 'GilroyMedium',
                      ),
                    ),
                    SizedBox(height: height / 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: dailogbutton(Colors.transparent,
                              LanguageEn.cancel, notifier.getred),
                        ),
                        SizedBox(width: width / 30),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OtpPage(input: _signUpInput),
                              ),
                            );
                          },
                          child: dailogbutton(notifier.getred, LanguageEn.next,
                              notifier.getwhite),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        );
      },
    );
  }

  Widget dailogbutton(buttoncolor, txt, textcolor) {
    return Container(
      height: height / 16,
      width: width / 3.8,
      decoration: BoxDecoration(
        color: buttoncolor,
        borderRadius: const BorderRadius.all(
          Radius.circular(13),
        ),
        // border: Border.all(color: bordercolor),
      ),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(
            color: textcolor,
            fontSize: height / 50,
            fontFamily: 'GilroyMedium',
          ),
        ),
      ),
    );
  }
  // Widget authbutton(buttoncolor, buttontextcolor, txt, w, image) {
  //   return Container(
  //     height: height / 14,
  //     width: w,
  //     decoration: BoxDecoration(
  //       color: buttoncolor,
  //       borderRadius: const BorderRadius.all(
  //         Radius.circular(15),
  //       ),
  //     ),
  //     child: Center(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Image.asset(image, height: height / 35),
  //           SizedBox(width: width / 30),
  //           Text(
  //             txt,
  //             style: TextStyle(
  //                 color: buttontextcolor,
  //                 fontSize: height / 50,
  //                 fontWeight: FontWeight.bold),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
