import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gofoods/custtomscreens/customtextField.dart';
import 'package:gofoods/custtomscreens/custtombutton.dart';
import 'package:gofoods/custtomscreens/textfild.dart';
import 'package:gofoods/model/input/signupinput.dart';
import 'package:gofoods/screens/authscreen/createaccount.dart';
import 'package:gofoods/screens/authscreen/forgotpassword.dart';
import 'package:gofoods/screens/authscreen/otp.dart';
import 'package:gofoods/screens/enablelocation.dart';
import 'package:gofoods/services/auth.dart';
import 'package:gofoods/utils/enstring.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  late ColorNotifier notifier;
  String? _selectedindex;
  bool isChecked = false;

  final _formKey = GlobalKey<FormState>();
  AuthService auth = AuthService();
  final SignUpInput _signUpInput = SignUpInput();

  final List<Map> _myjson = [
    {
      'id': '2',
      'image': 'assets/flagfour.png.png',
      'Text': "+92",
    },
    {
      'id': '3',
      'image': 'assets/flagthree.jpg',
      'Text': "+93",
    },
    {
      'id': '5',
      'image': 'assets/flagfive.png',
      'Text': "+95",
    }
  ];
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
                  Image.asset("assets/signin.jpg"),
                  Column(
                    children: [
                      SizedBox(height: height / 12),
                      Row(
                        children: [
                          SizedBox(width: width / 20),
                          Text(
                            LanguageEn.signin,
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
              // SizedBox(height: height / 7),
              // Row(
              //   children: [
              //     SizedBox(width: width / 20),
              //     Text(
              //       LanguageEn.enteryourphonenumber,
              //       style: TextStyle(
              //         color: notifier.getblackcolor,
              //         fontSize: height / 33,
              //         fontFamily: 'GilroyBold',
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: height / 100),
              // Row(
              //   children: [
              //     SizedBox(width: width / 20),
              //     Text(
              //       LanguageEn.pleaseenterphonenumber,
              //       style: TextStyle(
              //         color: notifier.getgrey,
              //         fontSize: height / 47,
              //         fontFamily: 'GilroyMedium',
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(height: height / 40),
              Row(
                children: [
                  SizedBox(width: width / 20),
                  Text(
                    LanguageEn.phonenumber,
                    style: TextStyle(
                      color: notifier.getgrey,
                      fontSize: height / 50,
                      fontFamily: 'GilroyMedium',
                    ),
                  ),
                ],
              ),
              SizedBox(height: height / 60),
              // mobailnotextfild(),
              // SizedBox(height: height / 50),
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
              // Customtextfild.textField(
              //     LanguageEn.enteryourpassword,
              //     notifier.getblackcolor,
              //     width / 1.13,
              //     Icons.lock,
              //     notifier.getbgfildcolor),
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
              Row(
                children: [
                  SizedBox(width: width / 30),
                  Transform.scale(
                    scale: 1,
                    child: Checkbox(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      activeColor: notifier.getred,
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            LanguageEn.remember,
                            style: TextStyle(
                                fontSize: height / 55, color: notifier.getgrey),
                          ),
                          SizedBox(width: width / 4.9),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPassword(),
                                ),
                              );
                            },
                            child: Text(
                              LanguageEn.forgotpassword,
                              style: TextStyle(
                                fontSize: height / 55,
                                color: const Color(0xff3a71d5),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // SizedBox(height: height / 13),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     authbutton(const Color(0xff3a71d5), Colors.white,
              //         LanguageEn.facebook, width / 2.3, "assets/facebook.png"),
              //     SizedBox(width: width / 25),
              //     authbutton(const Color(0xff323337), Colors.white,
              //         LanguageEn.apple, width / 2.3, "assets/apple.png")
              //   ],
              // ),
              SizedBox(height: height / 40),
              GestureDetector(
                onTap: () async {
                  // print("object");
                  // _showMyDialog();
                  _formKey.currentState?.save();
                  final isValid = _formKey.currentState?.validate() ?? false;

                  if (isValid) {
                    // print(_signUpInput.toMap());
                    await auth.signInRequest(_signUpInput);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EnableLocation(),
                      ),
                      (route) => false,
                    );
                  }
                },
                child: button(
                  notifier.getred,
                  notifier.getwhite,
                  LanguageEn.signin,
                  width / 1.1,
                ),
              ),
              // SizedBox(height: height / 50),
              // GestureDetector(
              //   onTap: () {
              //     _faceshowMyDialog();
              //   },
              //   child: button(const Color(0xff323337), Colors.white,
              //       LanguageEn.signinwithfaceid, width / 1.1),
              // ),
              SizedBox(height: height / 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LanguageEn.donothaveaccount,
                    style: TextStyle(
                      color: notifier.getgrey,
                      fontFamily: 'GilroyMedium',
                      fontSize: height / 55,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateAccount(),
                        ),
                      );
                    },
                    child: Text(
                      LanguageEn.signup,
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

  _faceshowMyDialog() async {
    return showDialog(
      context: context, useRootNavigator: true,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: notifier.getwhite,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                color: Colors.transparent,
                height: height / 3.4,
                // width: width / 1.1,
                child: Column(
                  children: [
                    SizedBox(height: height / 100),
                    Center(
                      child:
                          Image.asset("assets/FaceID.png", height: height / 13),
                    ),
                    SizedBox(height: height / 35),
                    Text(
                      LanguageEn.continuewithfaceid,
                      style: TextStyle(
                          color: notifier.getblackcolor,
                          fontFamily: 'GilroyBold',
                          fontSize: height / 35),
                    ),
                    SizedBox(height: height / 150),
                    Text(
                      LanguageEn.usefaceidtounlockcarr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: notifier.getgrey,
                          fontFamily: 'GilroyMedium',
                          fontSize: height / 60),
                    ),
                    SizedBox(height: height / 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: button(
                        notifier.getred,
                        notifier.getwhite,
                        LanguageEn.cancel,
                        width / 2,
                      ),
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

  Widget authbutton(buttoncolor, buttontextcolor, txt, w, image) {
    return Container(
      height: height / 14,
      width: w,
      decoration: BoxDecoration(
        color: buttoncolor,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: height / 35),
            SizedBox(width: width / 30),
            Text(
              txt,
              style: TextStyle(
                  color: buttontextcolor,
                  fontSize: height / 50,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  _showMyDialog() async {
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
                      LanguageEn.loginwithphonenumber,
                      style: TextStyle(
                        color: notifier.getgrey,
                        fontSize: height / 60,
                        fontFamily: 'GilroyMedium',
                      ),
                    ),
                    SizedBox(height: height / 60),
                    Text(
                      "(+84) 39 787 5256",
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
                                builder: (context) => const Otp(),
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

  Widget mobailnotextfild() {
    return Container(
      height: height / 16,
      width: width / 1.1,
      decoration: BoxDecoration(
        color: notifier.getbgfildcolor,
        borderRadius: const BorderRadius.all(
          Radius.circular(13),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: width / 100),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Row(
                children: [
                  Image.asset("assets/flagfour.png.png", height: height / 25),
                  Text(
                    "+91",
                    style: TextStyle(color: notifier.getblackcolor),
                  )
                ],
              ),
              value: _selectedindex,
              onChanged: (newValue) {
                setState(() {
                  _selectedindex = newValue;
                });
              },
              items: _myjson.map((Map map) {
                return DropdownMenuItem<String>(
                  value: map["id"].toString(),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        map["image"].toString(),
                        width: 35,
                      ),
                      Text(
                        map["Text"].toString(),
                        style: TextStyle(color: notifier.getblackcolor),
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Container(width: 1, height: height / 25, color: notifier.getgrey),
          SizedBox(width: width / 100),
          Container(
            color: Colors.transparent,
            height: 80,
            width: 190,
            child: TextField(
              style: TextStyle(color: notifier.getblackcolor),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: notifier.getgrey,
                      fontSize: height / 50,
                      fontFamily: 'GilroyMedium'),
                  border: InputBorder.none,
                  hintText: LanguageEn.enteryournumber),
            ),
          ),
        ],
      ),
    );
  }
}
