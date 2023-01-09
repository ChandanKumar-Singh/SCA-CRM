import 'package:crm_application/Provider/UserProvider.dart';
import 'package:crm_application/Screens/Cold%20Calls/ContactTabsScreen.dart';
import 'package:crm_application/Screens/Cold%20Calls/Intraction/InteractionsScreen.dart';
import 'package:crm_application/Screens/Cold%20Calls/MyLeads/MyLeadScreen.dart';
import '../Screens/DashBoard/LeavesPage.dart';
import 'package:crm_application/Screens/DashBoard/Vehicles/vehicles.dart';
import 'package:crm_application/Screens/DrawerPags/Notifications.dart';
import 'package:crm_application/Utils/Colors.dart';
import 'package:crm_application/Utils/ImageConst.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Screens/Cold Calls/ColdCallScreen.dart';
import '../Screens/Cold Calls/DialerScreen.dart';
import '../Screens/DashBoard/Reports/UsersActivity.dart';

Column LeadWidget(String name, BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    // ContactTabsScreen(pageIndex: 'interaction'),
                    const MyLeadScreen(),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: themeColor,
              // boxShadow: [
              //   BoxShadow(
              //     offset: const Offset(0, 10),
              //     blurRadius: 30,
              //     color: themeColor.withOpacity(0.23),
              //   ),
              // ],
            ),
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(35),
                child: Image.asset(
                  ImageConst.leads_icon,
                  color: const Color(0xFFdfc67a),
                  height: 80,
                ),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        name,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Column InteractionWidget(String name, BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    // ContactTabsScreen(pageIndex: 'interaction'),
                    const InteractionsScreen(),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: themeColor,
              // boxShadow: [
              //   BoxShadow(
              //     offset: const Offset(0, 10),
              //     blurRadius: 30,
              //     color: themeColor.withOpacity(0.23),
              //   ),
              // ],
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(35),
                child: Image.asset(
                  ImageConst.call_icon,
                  color: const Color(0xFFdfc67a),
                  height: 80,
                ),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        name,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Column VehiclesWidget(String name, BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    // ContactTabsScreen(pageIndex: 'interaction'),
                    const Vehicles(),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: themeColor,
              // boxShadow: [
              //   BoxShadow(
              //     offset: const Offset(0, 10),
              //     blurRadius: 30,
              //     color: themeColor.withOpacity(0.23),
              //   ),
              // ],
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  ImageConst.vehicle,
                  color: const Color(0xFFdfc67a),
                ),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        name,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Column NotificationsWidget(String name, BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    // ContactTabsScreen(pageIndex: 'interaction'),
                    Notifications(
                        authToken:
                            Provider.of<UserProvider>(context, listen: false)
                                .user
                                .token!),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: themeColor,
              // boxShadow: [
              //   BoxShadow(
              //     offset: const Offset(0, 10),
              //     blurRadius: 30,
              //     color: themeColor.withOpacity(0.23),
              //   ),
              // ],
            ),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.notifications,
                  color: Color(0xFFdfc67a),
                  size: 80,
                ),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        name,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Column DialerWidget(String name, BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DialerScreen(),
                ));
          },
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: themeColor,
              // boxShadow: [
              //   BoxShadow(
              //     offset: const Offset(0, 10),
              //     blurRadius: 30,
              //     color: themeColor.withOpacity(0.23),
              //   ),
              // ],
            ),
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(25),
                child: Image.asset(
                  ImageConst.keypad_icon,
                  color: Colors.white,
                  height: 40,
                ),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        name,
        style: const TextStyle(
          //fontFamily: 'avenir',
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Column ReportWidget(String name) {
  return Column(
    children: [
      Expanded(
        child: InkWell(
          onTap: () {
            // Get.to(UsersActivity());
          },
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: /*Color(0xfff1f3f6)*/ themeColor,
              // boxShadow: [
              //   BoxShadow(
              //     offset: const Offset(0, 10),
              //     blurRadius: 30,
              //     color: themeColor.withOpacity(0.23),
              //   ),
              // ],
            ),
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(25),
                child: Image.asset(
                  ImageConst.report_icon,
                  color: Colors.white,
                  height: 50,
                ),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        name,
        style: const TextStyle(
          //fontFamily: 'avenir',
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Column CallsWidget(String name, BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ColdCallScreen(),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: themeColor,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 10),
                  blurRadius: 30,
                  color: themeColor.withOpacity(0.23),
                ),
              ],
            ),
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(25),
                child: Image.asset(
                  ImageConst.cold_call,
                  color: Colors.white,
                  height: 50,
                ),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        name,
        style: const TextStyle(
          //fontFamily: 'avenir',
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Column LeavesWidget(String name, BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: InkWell(
          onTap: () {
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (context) => LeavesPage()));
          },
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: /*Color(0xfff1f3f6)*/ themeColor,
              // boxShadow: [
              //   BoxShadow(
              //     offset: const Offset(0, 10),
              //     blurRadius: 30,
              //     color: themeColor.withOpacity(0.23),
              //   ),
              // ],
            ),
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(25),
                child: Image.asset(
                  ImageConst.office_leave,
                  color: Colors.white,
                  height: 55,
                ),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        name,
        style: const TextStyle(
          //fontFamily: 'avenir',
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
