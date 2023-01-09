import 'package:crm_application/Screens/Cold%20Calls/ColdCallScreen.dart';
import 'package:crm_application/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class DialerScreen extends StatefulWidget {
  const DialerScreen({Key? key}) : super(key: key);

  @override
  State<DialerScreen> createState() => _DialerScreenState();
}

class _DialerScreenState extends State<DialerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: themeColor.withOpacity(0.1),
        title: const Text('Dialer'),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 15.0, bottom: 20),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ColdCallScreen(),
              ),
            );
          },
          child: Image.asset(
            'assets/images/call_icon.png',
            height: 45.h,
            width: 35.w,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      backgroundColor: themeColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: DialPad(
                  buttonColor: Colors.white,
                  enableDtmf: true,
                  outputMask: "0000000000",
                  dialButtonColor: themeColor,
                  backspaceButtonIconColor: Colors.red,
                  dialButtonIcon: Icons.call_sharp,
                  buttonTextColor: Colors.black,
                  dialOutputTextColor: Colors.black,
                  keyPressed: (value) {
                    print('$value was pressed');
                  },
                  makeCall: (number) {
                    setState(() {
                      if (number.isNotEmpty) {
                        launch('tel: $number');
                      }
                    });
                    print(number);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


