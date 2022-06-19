import 'package:flutter/material.dart';
import 'package:gofoods/custtomscreens/custtombutton.dart';
import 'package:gofoods/custtomscreens/textfild.dart';
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
      body: SingleChildScrollView(
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
            Customtextfild.textField(LanguageEn.enteryourfullname,
                notifier.getblackcolor, width / 1.13, Icons.person,notifier.getbgfildcolor),
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
            Customtextfild.textField(LanguageEn.enteryouremail,
                notifier.getblackcolor, width / 1.13, Icons.email,notifier.getbgfildcolor),
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
            Customtextfild.textField(LanguageEn.enteryourphonenumber,
                notifier.getblackcolor, width / 1.13, Icons.call,notifier.getbgfildcolor),
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
            Customtextfild.textField(LanguageEn.enteryourpassword,
                notifier.getblackcolor, width / 1.13, Icons.lock,notifier.getbgfildcolor),
            SizedBox(height: height / 15),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomHome(),
                  ),
                );
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
}
