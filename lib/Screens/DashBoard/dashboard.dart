import 'dart:convert';
import 'dart:io';
import 'package:crm_application/ApiManager/Apis.dart';
import 'package:crm_application/Models/NewModels/UserModel.dart';
import 'package:crm_application/Provider/UserProvider.dart';
import 'package:crm_application/Utils/Colors.dart';
import 'package:crm_application/Utils/ImageConst.dart';
import 'package:crm_application/Widgets/DrawerWidget.dart';
import 'package:crm_application/Widgets/IconsWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Models/DashBoardModel.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int? userId;
  var authToken, fName = '', lName = '';
  late SharedPreferences prefs;
  bool _isLoading = true;
  var tot_cold_call, tot_leads, tot_properties, featured_properties;
  List<FeaturedProperty> propertiesList = [];
  String? userProfile, availability;
  void init() async {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkState();
  }

  void checkState() async {
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId')!;
    fName = prefs.getString('fname')!;
    lName = prefs.getString('lname')!;
    userProfile = prefs.getString('image');
    availability = prefs.getString('availability');
    authToken = prefs.getString('token');
    debugPrint('CheckUserId : $userId');
    debugPrint('CheckUserName : $fName');
    debugPrint('CheckUserLName : $lName');
    getDashBoardDetails();
  }

  void getDashBoardDetails() async {
    var url = '${ApiManager.BASE_URL}${ApiManager.dashboard}';
    final headers = {
      'Authorization-token': '3MPHJP0BC63435345341',
      'Authorization': 'Bearer $authToken',
    };
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      var responseData = json.decode(response.body);
      print('DashboardResponse : ${responseData.toString()}');
      if (response.statusCode == 200) {
        var success = responseData['success'];
        tot_cold_call = responseData['tot_cold_call'];
        tot_leads = responseData['tot_leads'];
        tot_properties = responseData['tot_properties'];
        featured_properties = responseData['featured_properties'];
        if (success == 200) {
          setState(
            () {
              _isLoading = false;
            },
          );
          featured_properties.forEach((v) {
            propertiesList.add(FeaturedProperty.fromJson(v));
          });
        }
      } else {
        setState(
          () {
            _isLoading = false;
          },
        );
        throw const HttpException('Failed To get Leads');
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, up, _) {
        var data = up.user.data!;
        return Scaffold(
          key: _scaffoldKey,
          // appBar: AppBar(
          //   leading: IconButton(
          //     onPressed: () {
          //       _scaffoldKey.currentState?.openDrawer();
          //     },
          //     icon: const Icon(Icons.menu_open),
          //   ),
          //   backgroundColor: themeColor,
          //   elevation: 1,
          //   // title: Text('DashBoard(${up.user.role})'),
          //   title: const Text('DashBoard'),
          // ),
          drawer: CustomDrawer(
            userID: data.id,
            fname: data.firstName!,
            lname: data.lastName!,
            profile_url: data.userProfile,
            authToken: up.user.token,
            availability: data.availability,
          ),
          body: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    Container(
                      height: Get.height,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: themeColor,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.3,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // const SizedBox(height: 15),
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: kToolbarHeight,
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Opacity(
                                                    opacity: 0.7,
                                                    child: Image.asset(
                                                      ImageConst.AppLogo,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: kToolbarHeight,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    _scaffoldKey.currentState
                                                        ?.openDrawer();
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    width: 50,
                                                    height: 50,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              height: 3,
                                                              width: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: const Color(
                                                                    0xFFdfc67a),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 4),
                                                            Container(
                                                              height: 3,
                                                              width: 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: const Color(
                                                                    0xFFdfc67a),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 4),
                                                            Container(
                                                              height: 3,
                                                              width: 25,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: const Color(
                                                                    0xFFdfc67a),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: const Color(0xffcbab49),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Container(
                                                      height: 42,
                                                      width: 42,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.white,
                                                          image:
                                                              DecorationImage(
                                                            image: up.user.data!
                                                                            .userProfile ==
                                                                        null ||
                                                                    up.user.data!
                                                                            .userProfile ==
                                                                        ''
                                                                ? const AssetImage(
                                                                    'assets/images/person.jpeg',
                                                                  )
                                                                : NetworkImage(
                                                                    up
                                                                        .user
                                                                        .data!
                                                                        .userProfile!,
                                                                  ) as ImageProvider,
                                                            fit: BoxFit.cover,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(20),
                                //   child: Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       Text(
                                //         'DashBoard',
                                //         style: Get.textTheme.headline5!
                                //             .copyWith(color: Colors.white),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: Get.height * 0.3,
                      child: Container(
                        width: Get.width,
                        height: Get.height * 0.7,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            // Center(
                            //   child: SizedBox(
                            //     height: 200.h,
                            //     width: 200.h,
                            //     child: Image.asset(ImageConst.AppLogo,
                            //         fit: BoxFit.cover),
                            //   ),
                            // ),
                            const Spacer(),
                            SizedBox(
                              height: Get.height * .5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridView.count(
                                  // physics: const NeverScrollableScrollPhysics(),
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.8,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  children: [
                                    if(up.user.data!.permissionForCl==1)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: LeadWidget("MY LEADS", context),
                                    ),
                                    if(up.user.data!.permissionForCl==1)

                                      Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: InteractionWidget(
                                          "INTERACTIONS", context),
                                    ),
                                    if(up.user.data!.permissionMenu==1)

                                      Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child:
                                          VehiclesWidget("VEHICLES", context),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: NotificationsWidget(
                                          "NOTIFICATIONS", context),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
