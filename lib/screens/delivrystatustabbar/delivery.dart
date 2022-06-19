import 'package:flutter/material.dart';
import 'package:gofoods/utils/enstring.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Delivery extends StatefulWidget {
  const Delivery({Key? key}) : super(key: key);

  @override
  State<Delivery> createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  late ColorNotifier notifier;
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
    return Scaffold(backgroundColor: notifier.getwhite,
      body: Padding(
        padding: EdgeInsets.only(left: width / 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height / 90),
            Text(
              LanguageEn.burgerking,
              style: TextStyle(
                  color: notifier.getblackcolor,
                  fontSize: height / 45,
                  fontFamily: 'GilroyBold'),
            ),
            Text(
              LanguageEn.westernburger,
              style: TextStyle(
                  color: notifier.getgrey,
                  fontSize: height / 65,
                  fontFamily: 'GilroyBold'),
            ),
            SizedBox(height: height / 100),
            Row(
              children: [
                Icon(Icons.star,
                    size: height / 40, color: notifier.getstarcolor),
                Icon(Icons.star,
                    size: height / 40, color: notifier.getstarcolor),
                Icon(Icons.star,
                    size: height / 40, color: notifier.getstarcolor),
                Icon(Icons.star,
                    size: height / 40, color: notifier.getstarcolor),
                SizedBox(width: width / 3.5),
                kmtime(width / 6, Icons.location_on_outlined, "254m"),
                SizedBox(width: width / 50),
                kmtime(width / 8, Icons.timer, "27'"),
              ],
            ),
            SizedBox(height: height / 50),
            tags(Icons.check_box_outline_blank_outlined,LanguageEn.freeshipwithin),
            SizedBox(height: height / 100),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Divider(color: notifier.getgrey),
            ),
            SizedBox(height: height / 100),
            tags(Icons.discount,LanguageEn.offonallmenuitems),
          ],
        ),
      ),
    );
  }

  Widget tags(icon,txt) {
    return Row(
      children: [
        Container(
          height: height / 17,
          width: width / 8.5,
          decoration: BoxDecoration(
            color: notifier.getred,
            borderRadius: const BorderRadius.all(
              Radius.circular(13),
            ),
          ),
          child: Icon(icon,
              color: notifier.getwhite, size: height / 33),
        ),
        SizedBox(width: width / 40),
        Text(
          txt,
          style: TextStyle(
              color: notifier.getblackcolor,
              fontSize: height / 60,
              fontFamily: 'GilroyMedium'),
        )
      ],
    );
  }

  Widget kmtime(w, icon, txt) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const RestorentDeal(),
        //   ),
        // );
      },
      child: Container(
        height: height / 30,
        width: w,
        decoration: const BoxDecoration(
          color: Color(0xfff2f2f2),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: height / 70,
              color: notifier.getred,
            ),
            Text(
              txt,
              style: TextStyle(
                fontSize: height / 70,
                color: notifier.getred,
              ),
            )
          ],
        ),
      ),
    );
  }
}
