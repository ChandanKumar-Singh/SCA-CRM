import 'package:crm_application/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Provider/vehicles/VehicleProvider.dart';

class Vehicles extends StatefulWidget {
  const Vehicles({Key? key}) : super(key: key);

  @override
  State<Vehicles> createState() => _VehiclesState();
}

class _VehiclesState extends State<Vehicles> {
  bool searching = false;
  TextEditingController searchController = TextEditingController();
  void init() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {
      print(prefs.getString('token'));
      Provider.of<VehicleProvider>(context, listen: false).token =
          prefs.getString('token');
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<bool> onWillPop(BuildContext context) async {
    var vp = Provider.of<VehicleProvider>(context, listen: false);
    if (searching) {
      searching = false;
      setState(() {});
      return false;
    } else {
      vp.vehiclesList.clear();
      vp.vehicle = null;
      return await Future.delayed(const Duration(seconds: 0), () => true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var willBack = await onWillPop(context);
        print(willBack);
        return willBack;
      },
      child: Scaffold(
        body: Consumer<VehicleProvider>(builder: (context, vp, _) {
          // print(vp.scrollController.position.);
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Search with Reg No.',
                              hintStyle: GoogleFonts.lobster(),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(color: themeColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(color: themeColor),
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                            ),
                            onChanged: (val) async {
                              setState(() {
                                val.isNotEmpty
                                    ? searching = true
                                    : searching = false;
                              });
                              if (val.length > 4) {
                                vp.getVehicles(val, false);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              searchController.text.isNotEmpty
                                  ? searching = true
                                  : searching = false;
                            });
                            vp.getVehicles(searchController.text, false);
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: themeColor,
                              border: Border.all(),
                            ),
                            child: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (searching)
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  height: Get.height * 0.5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    // color: Colors.pink,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: ListView(
                                      controller: vp.scrollController,
                                      children: [
                                        if (vp.vehiclesList.isNotEmpty)
                                          ...vp.vehiclesList.map(
                                            (e) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  vp.vehicle = e;
                                                  searching = false;
                                                  setState(() {});
                                                  vp.loadSuggestionImage(
                                                      vp.vehicle!.vehicle ??
                                                          '');
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: themeColor
                                                        .withOpacity(1),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(
                                                            width: 10),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              e.registrationNo!
                                                                  .toUpperCase(),
                                                              style: GoogleFonts
                                                                      .notoSerifMalayalam()
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          20),
                                                            ),
                                                            const SizedBox(
                                                                height: 5),
                                                            Text(
                                                              e.cmName!
                                                                  .capitalize!,
                                                              style: GoogleFonts
                                                                      .notoSerifMalayalam()
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          18),
                                                            ),
                                                            const SizedBox(
                                                                height: 5),
                                                            Text(
                                                              e.appId!
                                                                  .toString()
                                                                  .toUpperCase(),
                                                              style: GoogleFonts
                                                                      .notoSerifMalayalam()
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          18),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                        if (vp.vehiclesList.isEmpty&&!vp.isLoadingResult)
                                          Column(
                                            children: [
                                              const SizedBox(height: 200),
                                              Text(
                                                'Vehicle not found',
                                                style: GoogleFonts.alef()
                                                    .copyWith(fontSize: 20),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Positioned(
                                //     top: 0,
                                //     right: 10,
                                //     child: Text(
                                //       '${vp.vehiclesList.length}/${vp.total} found',
                                //       style: const TextStyle(fontSize: 12),
                                //     )),
                                if (vp.isLoadingResult)
                                  Positioned(
                                      top: 10,
                                      bottom: 10,
                                      left: 10,
                                      right: 10,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          // color: const Color(0x279196EC),
                                        ),
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )),
                                // if (vp.vehiclesList.length < vp.total &&
                                //     vp.vehiclesList.isNotEmpty)
                                //   Positioned(
                                //       bottom: 10,
                                //       right: 20,
                                //       child: ElevatedButton(
                                //           onPressed: () async {
                                //             await vp.getVehicles(
                                //                 searchController.text, true);
                                //             FocusManager.instance.primaryFocus
                                //                 ?.unfocus();
                                //           },
                                //           style: ElevatedButton.styleFrom(
                                //               backgroundColor: Colors.grey,
                                //               shape: RoundedRectangleBorder(
                                //                   borderRadius:
                                //                       BorderRadius.circular(
                                //                           10))),
                                //           child: Text('Show more')))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (!searching && vp.vehicle != null)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              // vp.vehicle = e;
                              // searching = false;
                              // setState(() {});
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      AspectRatio(
                                        aspectRatio:
                                            Get.height / Get.width / 1.5,
                                        child: Container(
                                          // height: Get.width - 20,
                                          // width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            // color: themeColor.withOpacity(0.8),
                                            image: DecorationImage(
                                                image: vp.suggestedImg !=
                                                            null &&
                                                        vp.suggestedImg != ''
                                                    ? NetworkImage(
                                                        vp.suggestedImg!,
                                                      )
                                                    : const AssetImage(
                                                        'assets/images/vehicle_placeholder.png',
                                                      ) as ImageProvider,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: themeColor.withOpacity(01),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        vp.vehicle!
                                                            .registrationNo!
                                                            .toUpperCase(),
                                                        style: GoogleFonts
                                                                .notoSerifMalayalam()
                                                            .copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 32),
                                                      ),
                                                      Text(
                                                        'Loan No. : ${vp.vehicle!.loanNo ?? ''}',
                                                        style: GoogleFonts
                                                                .notoSerifMalayalam()
                                                            .copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 22),
                                                      ),
                                                      Text(
                                                        'Owner : ${vp.vehicle!.cmName ?? ''}',
                                                        style: GoogleFonts
                                                                .notoSerifMalayalam()
                                                            .copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 22),
                                                      ),
                                                      const SizedBox(
                                                          height: 30),
                                                      Text(
                                                        'Details :',
                                                        style: GoogleFonts
                                                                .libreCaslonDisplay()
                                                            .copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 35,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      Card(
                                                        color:
                                                            Colors.transparent,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                            side: BorderSide.lerp(
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                20)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'Model : ${vp.vehicle!.vehicle ?? ''}',
                                                            style: GoogleFonts
                                                                    .notoSerifMalayalam()
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        22),
                                                          ),
                                                        ),
                                                      ),
                                                      Card(
                                                        color:
                                                            Colors.transparent,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                            side: BorderSide.lerp(
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                20)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'Engine No. : ${vp.vehicle!.engineNo ?? ''}',
                                                            style: GoogleFonts
                                                                    .notoSerifMalayalam()
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        22),
                                                          ),
                                                        ),
                                                      ),
                                                      Card(
                                                        color:
                                                            Colors.transparent,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                            side: BorderSide.lerp(
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                20)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'Chassis No. : ${vp.vehicle!.chassisNo ?? ''}',
                                                            style: GoogleFonts
                                                                    .notoSerifMalayalam()
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        22),
                                                          ),
                                                        ),
                                                      ),
                                                      Card(
                                                        color:
                                                            Colors.transparent,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                            side: BorderSide.lerp(
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                20)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'Application Id : ' +
                                                                vp.vehicle!
                                                                    .appId!
                                                                    .toString()
                                                                    .capitalize!,
                                                            style: GoogleFonts
                                                                    .notoSerifMalayalam()
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        22),
                                                          ),
                                                        ),
                                                      ),
                                                      Card(
                                                        color:
                                                            Colors.transparent,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                            side: BorderSide.lerp(
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                20)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'Branch : ${vp.vehicle!.branch ?? ''}',
                                                            style: GoogleFonts
                                                                    .notoSerifMalayalam()
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        22),
                                                          ),
                                                        ),
                                                      ),
                                                      Card(
                                                        color:
                                                            Colors.transparent,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                            side: BorderSide.lerp(
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                20)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'State : ${vp.vehicle!.stateName ?? ''}',
                                                            style: GoogleFonts
                                                                    .notoSerifMalayalam()
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        22),
                                                          ),
                                                        ),
                                                      ),
                                                      Card(
                                                        color:
                                                            Colors.transparent,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                            side: BorderSide.lerp(
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                20)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'BKT : ${vp.vehicle!.bkt ?? ''}',
                                                            style: GoogleFonts
                                                                    .notoSerifMalayalam()
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        22),
                                                          ),
                                                        ),
                                                      ),
                                                      Card(
                                                        color:
                                                            Colors.transparent,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                            side: BorderSide.lerp(
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                20)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'Actual BKT : ${vp.vehicle!.actualBkt ?? ''}',
                                                            style: GoogleFonts
                                                                    .notoSerifMalayalam()
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        22),
                                                          ),
                                                        ),
                                                      ),
                                                      Card(
                                                        color:
                                                            Colors.transparent,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                            side: BorderSide.lerp(
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                20)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'TOS : ${vp.vehicle!.tos ?? ''}',
                                                            style: GoogleFonts
                                                                    .notoSerifMalayalam()
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        22),
                                                          ),
                                                        ),
                                                      ),
                                                      Card(
                                                        color:
                                                            Colors.transparent,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                            side: BorderSide.lerp(
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                20)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'POS : ${vp.vehicle!.pos ?? ''}',
                                                            style: GoogleFonts
                                                                    .notoSerifMalayalam()
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        22),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
