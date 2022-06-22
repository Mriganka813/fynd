import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gofoods/custtomscreens/custtombutton.dart';
import 'package:gofoods/model/input/signupinput.dart';
import 'package:gofoods/screens/enablelocation.dart';
import 'package:gofoods/services/auth.dart';
import 'package:gofoods/utils/enstring.dart';
import 'package:gofoods/utils/global.dart';
import 'package:gofoods/utils/locator.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpPage extends StatefulWidget {
  final SignUpInput input;
  const OtpPage({Key? key, required this.input}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late ColorNotifier notifier;
  final _authInstace = FirebaseAuth.instance;
  String _verificationId = "";
  String code = "";
  String smsotp = "";
  bool isverified = false;
  AuthService auth = AuthService();

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
    getotp(widget.input.phoneNumber!);
    getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.getbgcolor,
      body: Column(
        children: [
          SizedBox(height: height / 6),
          Row(
            children: [
              SizedBox(width: width / 20),
              Text(
                LanguageEn.verificationcodeotp,
                style: TextStyle(
                    color: notifier.getblackcolor,
                    fontSize: height / 35,
                    fontFamily: 'GilroyBold'),
              ),
            ],
          ),
          SizedBox(height: height / 60),
          Row(
            children: [
              SizedBox(width: width / 20),
              Text(
                LanguageEn.averificationcodeshasbeensendto,
                style: TextStyle(
                    color: notifier.getgrey,
                    fontSize: height / 50,
                    fontFamily: 'GilroyMedium'),
              ),
            ],
          ),
          SizedBox(height: height / 100),
          Row(
            children: [
              SizedBox(width: width / 20),
              Text(
                widget.input.phoneNumber!,
                style: TextStyle(
                  fontFamily: 'GilroyBold',
                  color: notifier.getblackcolor,
                  fontSize: height / 50,
                ),
              ),
            ],
          ),
          SizedBox(height: height / 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              code == "" ? otpfild("") : otpfild(code.characters.elementAt(0)),
              code == "" ? otpfild("") : otpfild(code.characters.elementAt(1)),
              code == "" ? otpfild("") : otpfild(code.characters.elementAt(2)),
              code == "" ? otpfild("") : otpfild(code.characters.elementAt(3)),
              code == "" ? otpfild("") : otpfild(code.characters.elementAt(4)),
              code == "" ? otpfild("") : otpfild(code.characters.elementAt(5)),
            ],
          ),
          SizedBox(height: height / 20),
          GestureDetector(
            onTap: () async {
              if (smsotp == "" && code == "") {
                locator<GlobalServices>().errorSnackBar("Verification Failed");
                return;
              }
              await verifyOtp();
              isverified
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EnableLocation(),
                      ),
                    )
                  : Navigator.pop(context);
            },
            child: button(
              notifier.getred,
              notifier.getwhite,
              LanguageEn.next,
              width / 1.13,
            ),
          ),
          SizedBox(height: height / 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LanguageEn.dontreceivedthecode,
                style: TextStyle(
                    color: notifier.getgrey, fontFamily: 'GilroyMedium'),
              ),
              SizedBox(width: width / 200),
              Text(
                "Resend(42 S)",
                style: TextStyle(
                    color: notifier.getred, fontFamily: 'GilroyMedium'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget otpfild(digit) {
    print(digit);
    return Container(
      height: height / 15,
      width: width / 8,
      decoration: BoxDecoration(
        color: notifier.getbgfildcolor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextFormField(
        key: Key(digit),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        keyboardType: TextInputType.number,
        initialValue: digit,
        onChanged: (value) {
          if (value.length == 1) {
            smsotp = smsotp + value;
            FocusScope.of(context).nextFocus();
          }
        },
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: height / 40,
            color: notifier.getblackcolor,
            fontFamily: 'Gilroy Bold'),
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }

  ///
  getotp(String phone) async {
    await _authInstace.verifyPhoneNumber(
      phoneNumber: '+91$phone',
      verificationCompleted: (PhoneAuthCredential credential) async {
        setState(() {
          code = credential.smsCode!;
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        locator<GlobalServices>().errorSnackBar("Verification Failed");
      },
      codeSent: (String verificationId, int? resendToken) {
        locator<GlobalServices>().successSnackBar("Code sent");
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  ///
  verifyOtp() async {
    print("if not" + smsotp);
    print("code" + code);
    locator<GlobalServices>().infoSnackBar("Verifying...");
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: code != "" ? code : smsotp);

    try {
      await _authInstace.signInWithCredential(credential).then((value) {
        locator<GlobalServices>().successSnackBar("Verified ✓");

        setState(() {
          isverified = true;
        });
      });

      auth.signUpRequest(widget.input);
    } catch (e) {
      locator<GlobalServices>().errorSnackBar("Verificastion falied");
      setState(() {
        code = "";
        smsotp = "";
        isverified = true;
      });
    }
  }
}
