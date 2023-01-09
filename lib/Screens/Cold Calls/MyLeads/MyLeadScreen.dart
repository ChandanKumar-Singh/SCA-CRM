import 'dart:convert';
import 'dart:io';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:crm_application/Models/LeadsModel.dart';
import 'package:crm_application/Provider/UserProvider.dart';
import 'package:crm_application/Screens/Cold%20Calls/MyLeads/LeadFilter/Models/agentsModel.dart';
import 'package:crm_application/Screens/Cold%20Calls/MyLeads/ClosedLeads/closedLeads.dart';
import 'package:crm_application/Screens/Cold%20Calls/MyLeads/LeadFilter/Models/developerModel.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:crm_application/Screens/Cold%20Calls/MyLeads/TestCallDetailsScreen/TestCallScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Provider/LeadsProvider.dart';
import '../../../Utils/Colors.dart';
import '../../../Utils/ImageConst.dart';
import 'LeadFilter/Filter/FilterUI.dart';
import 'LeadFilter/Models/propertyModel.dart';
import 'LeadFilter/Models/statusModel.dart';
import 'LeadFilter/Models/stausmodel.dart';
import 'package:selectable/selectable.dart';

class MyLeadScreen extends StatefulWidget {
  const MyLeadScreen({Key? key}) : super(key: key);

  @override
  State<MyLeadScreen> createState() => _MyLeadScreenState();
}

class _MyLeadScreenState extends State<MyLeadScreen> {
  late SharedPreferences pref;
  var authToken, responseData, url;
  int? sssPermission;
  int? clPermission;
  String TAG = 'MyLeadScreen';

  bool isAddingContact = false;

  void getPrefs() async {
    pref = await SharedPreferences.getInstance();
    authToken = pref.getString('token');
    sssPermission = pref.getInt('sssPermission');
    clPermission = pref.getInt('clPermission');
    try {
      Provider.of<LeadsProvider>(context, listen: false).token = authToken;
      Provider.of<LeadsProvider>(context, listen: false).role =
          jsonDecode(pref.getString('user')!)['role'];
      await Provider.of<LeadsProvider>(context, listen: false).getLeads();
      await Provider.of<LeadsProvider>(context, listen: false)
          .initFilterMethods();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
    Provider.of<LeadsProvider>(context, listen: false).controller =
        ScrollController()
          ..addListener(
              Provider.of<LeadsProvider>(context, listen: false).loadMore);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    Provider.of<LeadsProvider>(context, listen: false)
        .controller
        .removeListener(
            Provider.of<LeadsProvider>(context, listen: false).loadMore);
    super.dispose();
  }

  Future<bool> onWillPop(BuildContext context) async {
    var lp = Provider.of<LeadsProvider>(context, listen: false);
    print(
        'On will Pop Scope selection mode-- > ' + lp.selectionMode.toString());
    if (lp.selectionMode) {
      lp.selectionMode = false;
      lp.isLoadMoreRunning = false;
      lp.isLoadMoreRunning = false;
      lp.selectedLeads.clear();
      setState(() {});
      return false;
    } else {
      return await lp.isFilterApplied(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var willBack = await onWillPop(context);

        return willBack;
      },
      child: Consumer<LeadsProvider>(builder: (context, lp, _) {
        return Scaffold(
          appBar: !lp.selectionMode
              ? filterModeAppBar(lp)
              : AppBar(
                  backgroundColor: themeColor,
                  leading: IconButton(
                    onPressed: () {
                      lp.selectionMode = false;
                      lp.selectedLeads.clear();
                      setState(() {});
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  title: Text(
                    '${lp.selectedLeads.length} Selected',
                    style: const TextStyle(color: Colors.white),
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size(Get.width, 55),
                    child: SizedBox(
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  const SizedBox(width: 20),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xF2C08004),
                                      disabledBackgroundColor:
                                          const Color(0xABA4A3A3),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                    onPressed: lp.selectedLeads.isNotEmpty
                                        ? () async {
                                            await showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (context) {
                                                  return Dialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                    child:
                                                        LeadAssignmentToLeaderDialog(
                                                            lp: lp),
                                                  );
                                                });
                                          }
                                        : null,
                                    child: const Text(
                                      'Assign To Team Leader',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: themeColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                    onPressed: lp.selectedLeads.isNotEmpty
                                        ? () async {
                                            await showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (context) {
                                                  return Dialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                    child:
                                                        LeadAssignmentToAgentDialog(
                                                            lp: lp),
                                                  );
                                                });
                                          }
                                        : null,
                                    child: const Text(
                                      'Assign To Agent',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xF2E52121),
                                      disabledBackgroundColor:
                                          const Color(0xABA4A3A3),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                    onPressed: lp.selectedLeads.isNotEmpty
                                        ? () {
                                            AwesomeDialog(
                                              dismissOnBackKeyPress: false,
                                              dismissOnTouchOutside: false,
                                              context: context,
                                              dialogType: DialogType.warning,
                                              animType: AnimType.rightSlide,
                                              title:
                                                  'Are you sure to delete this leads?',
                                              desc:
                                                  'After delete permanently,\nit will not be retrieve.',
                                              btnCancelOnPress: () {},
                                              btnOkOnPress: () async {
                                                await lp.bulkDelete();
                                              },
                                            ).show();
                                          }
                                        : null,
                                    child: const Text(
                                      'Bulk Delete',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                        height: 45),
                  ),
                ),
          body: !lp.IsLoading
              ? Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: LeadsCard(
                            lp: lp,
                          ),
                        ),
                        if (lp.isLoadMoreRunning == true)
                          const Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 25),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      ],
                    ),
                    isAddingContact
                        ? Container(
                            color: const Color(0x30595B59),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Container(),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      }),
    );
  }

  AppBar filterModeAppBar(LeadsProvider lp) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(child: Text(' Active Leads')),
          Text('( ${lp.total} )')
        ],
      ),
      backgroundColor: themeColor,
      actions: [
        Stack(
          children: [
            IconButton(
                onPressed: () {
                  Get.to(LeadsFilters(token: authToken));
                },
                icon: const Icon(Icons.filter_list_outlined)),
            if (lp.isFlrApplied)
              const Positioned(
                child: Icon(
                  Icons.circle,
                  color: Colors.red,
                  size: 8,
                ),
                top: 12,
                right: 12,
              ),
          ],
        ),
        const SizedBox(width: 10),
        // PopupMenuButton<int>(
        //   onSelected: (val) {
        //     if (val == 0) {
        //       // Get.to(const ClosedLeadsScreen());
        //     }
        //     if (val == 1) {
        //       // Get.to(const SSSScreen());
        //     }
        //   },
        //   icon: const Icon(Icons.more_vert),
        //   itemBuilder: (context) {
        //     return [
        //       PopupMenuItem(
        //           value: 0,
        //           child: Row(
        //             children: const [
        //               FaIcon(
        //                 FontAwesomeIcons.solidFolderClosed,
        //                 color: Colors.black,
        //               ),
        //               SizedBox(width: 10),
        //               Text('CLosed Leads')
        //             ],
        //           )),
        //       if (lp.role == UserType.admin.name || sssPermission == 1)
        //         PopupMenuItem(
        //             value: 1,
        //             child: Row(
        //               children: const [
        //                 Icon(
        //                   Icons.reviews_rounded,
        //                   color: Colors.black,
        //                 ),
        //                 SizedBox(width: 10),
        //                 Expanded(
        //                     child: Text('Service Satisfactory Survey (SSS)'))
        //               ],
        //             )),
        //     ];
        //   },
        //   shape:
        //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        //   padding: const EdgeInsets.all(10),
        // ),
      ],
      bottom: lp.isFlrApplied
          ? PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: Container(
                height: 60,
                width: Get.width,
                // color: Colors.grey,
                padding: const EdgeInsets.only(left: 10),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    if (lp.selectedAgent != null)
                      GestureDetector(
                        onTap: () {
                          Get.to(
                              LeadsFilters(token: lp.token, selectedIndex: 0));
                        },
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(LeadsFilters(
                                    token: lp.token, selectedIndex: 0));
                              },
                              child: Chip(
                                deleteIcon: const Icon(Icons.clear),
                                label: lp.role != UserType.admin.name
                                    ? Text(lp.agentsByTeamList
                                        .firstWhere((element) => element.agents!
                                            .any((ele) =>
                                                ele.id == lp.selectedAgent))
                                        .agents!
                                        .firstWhere((element) =>
                                            element.id == lp.selectedAgent)
                                        .name!)
                                    : Text(lp.agentsByIdList
                                        .firstWhere((element) =>
                                            element.id == lp.selectedAgent)
                                        .name!),
                                onDeleted: () async {
                                  setState(() {
                                    lp.selectedAgent = null;
                                  });
                                  await lp.applyFilter(lp);
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    if (lp.fromDate != null || lp.toDate != null)
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(LeadsFilters(
                                  token: lp.token, selectedIndex: 1));
                            },
                            child: Chip(
                              deleteIcon: const Icon(Icons.clear),
                              // deleteIconColor: Colors.red,
                              label: Text(
                                  lp.fromDate != null && lp.toDate != null
                                      ? DateFormat('yyyy-MM-dd')
                                              .format(lp.fromDate!) +
                                          '  To  ' +
                                          DateFormat('yyyy-MM-dd')
                                              .format(lp.toDate!)
                                      : lp.fromDate != null
                                          ? DateFormat('yyyy-MM-dd')
                                              .format(lp.fromDate!)
                                          : lp.toDate != null
                                              ? '  To  ' +
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(lp.toDate!)
                                              : ''),
                              onDeleted: () async {
                                setState(() {
                                  lp.fromDate = null;
                                  lp.toDate = null;
                                });
                                await lp.applyFilter(lp);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    if (lp.selectedDeveloper != null)
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(LeadsFilters(
                                  token: lp.token, selectedIndex: 2));
                            },
                            child: Chip(
                              deleteIcon: const Icon(Icons.clear),
                              label: Text(lp.developersList
                                  .firstWhere((element) =>
                                      element.id == lp.selectedDeveloper)
                                  .name!),
                              onDeleted: () async {
                                setState(() {
                                  lp.selectedDeveloper = null;
                                });
                                await lp.applyFilter(lp);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    if (lp.selectedProperty != null)
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(LeadsFilters(
                                  token: lp.token, selectedIndex: 3));
                            },
                            child: Chip(
                              deleteIcon: const Icon(Icons.clear),
                              label: Text(lp.propertyList
                                  .firstWhere((element) =>
                                      element.id == lp.selectedProperty)
                                  .name!),
                              onDeleted: () async {
                                setState(() {
                                  lp.selectedProperty = null;
                                });
                                await lp.applyFilter(lp);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    if (lp.multiSelectedStatus.isNotEmpty)
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(LeadsFilters(
                                  token: lp.token, selectedIndex: 2));
                            },
                            child: PopupMenuButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              itemBuilder: (context) {
                                return [
                                  ...lp.multiSelectedStatus.map(
                                    (e) => PopupMenuItem(
                                        child: Chip(
                                      deleteIcon: const Icon(Icons.clear),
                                      label: Text(e.name!),
                                      onDeleted: () async {
                                        setState(() {
                                          lp.multiSelectedStatus.remove(e);
                                        });
                                        Get.back();
                                        await lp.applyFilter(lp);
                                      },
                                    )),
                                  ),
                                ];
                              },
                              child: Chip(
                                deleteIcon: const Icon(Icons.arrow_drop_down),
                                label: Row(
                                  children: [
                                    Text(
                                        '${lp.multiSelectedStatus.length} Status'),
                                    const Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    if (lp.multiSelectedSources.isNotEmpty)
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(LeadsFilters(
                                  token: lp.token, selectedIndex: 3));
                            },
                            child: PopupMenuButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              itemBuilder: (context) {
                                return [
                                  ...lp.multiSelectedSources.map(
                                    (e) => PopupMenuItem(
                                        child: Chip(
                                      deleteIcon: const Icon(Icons.clear),
                                      label: Text(e.name!),
                                      onDeleted: () async {
                                        setState(() {
                                          lp.multiSelectedSources.remove(e);
                                        });
                                        Get.back();
                                        await lp.applyFilter(lp);
                                      },
                                    )),
                                  ),
                                ];
                              },
                              child: Chip(
                                deleteIcon: const Icon(Icons.arrow_drop_down),
                                label: Row(
                                  children: [
                                    Text(
                                        '${lp.multiSelectedSources.length} Sources'),
                                    const Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    if (lp.selectedPriority != null)
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(LeadsFilters(
                                  token: lp.token, selectedIndex: 4));
                            },
                            child: Chip(
                              deleteIcon: const Icon(Icons.clear),
                              label: Text(lp.selectedPriority!),
                              onDeleted: () async {
                                setState(() {
                                  lp.selectedPriority = null;
                                });
                                await lp.applyFilter(lp);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    if (lp.query.text.isNotEmpty)
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(LeadsFilters(
                                  token: lp.token, selectedIndex: 5));
                            },
                            child: Chip(
                              deleteIcon: const Icon(Icons.clear),
                              label: Text(lp.query.text),
                              onDeleted: () async {
                                setState(() {
                                  lp.query.clear();
                                });
                                await lp.applyFilter(lp);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    if (lp.queryBkt.text.isNotEmpty)
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(LeadsFilters(
                                  token: lp.token, selectedIndex: 6));
                            },
                            child: Chip(
                              deleteIcon: const Icon(Icons.clear),
                              label: Text(lp.queryBkt.text),
                              onDeleted: () async {
                                setState(() {
                                  lp.queryBkt.clear();
                                });
                                await lp.applyFilter(lp);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    if (lp.selectedProd != null&&
                        lp.selectedProd !=
                            'All')
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(LeadsFilters(
                                  token: lp.token, selectedIndex: 7));
                            },
                            child: Chip(
                              deleteIcon: const Icon(Icons.clear),
                              label: Text(lp.selectedProd!),
                              onDeleted: () async {
                                setState(() {
                                  lp.selectedProd = null;
                                });
                                await lp.applyFilter(lp);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}

class LeadsCard extends StatefulWidget {
  const LeadsCard({Key? key, required this.lp}) : super(key: key);
  final LeadsProvider lp;

  @override
  State<LeadsCard> createState() => _LeadsCardState();
}

class _LeadsCardState extends State<LeadsCard> {
  bool isVisible = false;
  var whatsapp;
  _callNumber(String number) async {
    const numbrr = '08592119XXXX'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  openWhatsapp(String number) async {
    whatsapp = '+$number';
    debugPrint(number);
    debugPrint(whatsapp);
    var whatsappURlAndroid = "whatsapp://send?phone=$whatsapp";
    var whatappURLIos = "https://wa.me/$whatsapp";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURLIos)) {
        await launch(whatappURLIos, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURlAndroid)) {
        await launch(whatsappURlAndroid);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("whatsapp no installed"),
          behavior: SnackBarBehavior.floating,
        ));
      }
    }
  }

  _textMe(var number) async {
    // Android
    var uri = "sms:$number?body=hello%20there";
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      var uri = 'sms:$number?body=hello%20there';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Could not open message app"),
          behavior: SnackBarBehavior.floating,
        ));
        throw 'Could not launch $uri';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.lp.controller,
      physics: const BouncingScrollPhysics(),
      children: [
        ...widget.lp.leadsData.map((lead) {
          String agentsName = '';
          if (lead.agents != null || lead.agents!.isNotEmpty) {
            lead.agents!.length > 1 ? isVisible = true : isVisible = false;
            for (var element in lead.agents!) {
              agentsName += "${element.fullName},";
            }
            if (agentsName.length > 1) {
              agentsName = agentsName.substring(0, agentsName.length - 1);
            }
          }
          var isSelected =
              widget.lp.selectedLeads.any((element) => element.id == lead.id);
          String colorCode;
          var color = const Color(0xFF000000);
          if (lead.statuses != null) {
            colorCode = lead.statuses!.color!
                .substring(1, lead.statuses!.color!.length - 1);
            colorCode = '0xFF' + colorCode;
            var intCode = int.parse(colorCode);
            color = Color(intCode);
          }
          return Selectable(
            selectWordOnLongPress: true,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  if (!widget.lp.selectionMode) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LeadDetail(
                          lead: lead,
                        ),
                      ),
                    );
                  } else {
                    widget.lp.setSelectedLeads(lead);
                    if (widget.lp.selectedLeads.isEmpty) {
                      widget.lp.selectionMode = false;
                      setState(() {});
                    }
                  }
                },
                child: Card(
                  elevation: 3,
                  shadowColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: isSelected ? const Color(0xC3B7DBF5) : Colors.white,
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    foregroundDecoration: lead.contactabilityIndex != null
                        ? RotatedCornerDecoration(
                            color: themeColor,
                            geometry: BadgeGeometry(
                                width: lead.contactabilityIndex!
                                            .split(' ')
                                            .length >
                                        1
                                    ? 100
                                    : 60,
                                cornerRadius: 10,
                                height: 60),
                            textSpan: TextSpan(
                              children: [
                                TextSpan(
                                  text: lead.contactabilityIndex!
                                      .split(' ')
                                      .first,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                if (lead.contactabilityIndex!
                                        .split(' ')
                                        .length >
                                    1)
                                  TextSpan(
                                    text: '\n' +
                                        lead.contactabilityIndex!.split(' ')[1],
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                              ],
                            ),
                            labelInsets: const LabelInsets(baselineShift: 3),
                          )
                        : null,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text('Loan ID : ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            overflow: TextOverflow.ellipsis),
                                        Expanded(
                                          child: Text(
                                            lead.loanAgreementNo.toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(lead.customername.toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Get
                                                .theme.textTheme.caption!.color,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis),
                                        overflow: TextOverflow.ellipsis),
                                    const SizedBox(height: 3),
                                    Row(
                                      children: [
                                        const Text('Application ID : ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            overflow: TextOverflow.ellipsis),
                                        Expanded(
                                          child: Text(
                                            lead.applicationId.toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    Row(
                                      children: [
                                        const Text('Registration No. : ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            overflow: TextOverflow.ellipsis),
                                        Expanded(
                                          child: Text(
                                            lead.registrationNo ?? '',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 7),
                                    SizedBox(
                                      width: 180,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons
                                                      .moneyBillWave,
                                                  size: 13,
                                                  color:
                                                      Colors.red.withOpacity(1),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    lead.loanAmount != null
                                                        ? 'Rs.' +
                                                            lead.loanAmount
                                                                .toString()
                                                        : '',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      overflow:
                                                          TextOverflow.fade,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 7),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.paypal,
                                                  size: 13,
                                                  color: Colors.teal
                                                      .withOpacity(1),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    lead.emiDue != null
                                                        ? 'Rs.' +
                                                            lead.emiDue
                                                                .toString()
                                                        : '',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      overflow:
                                                          TextOverflow.fade,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.codeBranch,
                                                color:
                                                    Colors.green.withOpacity(1),
                                                size: 15,
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  lead.branch ?? '',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              '📱',
                                              style: TextStyle(
                                                fontSize: 14,
                                                overflow: TextOverflow.fade,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              lead.customerAddMobile != null &&
                                                      lead.customerAddMobile!
                                                              .length >
                                                          5
                                                  ? lead.customerAddMobile!
                                                  : 'N/A',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                overflow: TextOverflow.fade,
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
                            InkWell(
                              onTap: () {
                                print('call');
                                try {
                                  _callNumber('tel:${lead.customerAddMobile}');
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 18.0,
                                ),
                                child: Image.asset(
                                  ImageConst.call_icon,
                                  height: 25,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(height: 15),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Row(
                            children: [
                              const Expanded(child: Divider(thickness: 1)),
                              const SizedBox(width: 10),
                              Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.batteryHalf,
                                      color: themeColor, size: 15),
                                  const SizedBox(width: 5),
                                  Text(
                                    lead.digitalAffinity != null
                                        ? lead.digitalAffinity!
                                        : "N/A",
                                    style: TextStyle(
                                      fontSize: 14,
                                      overflow: TextOverflow.fade,
                                      color: themeColor,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class LeadAssignmentToLeaderDialog extends StatefulWidget {
  const LeadAssignmentToLeaderDialog({
    Key? key,
    required this.lp,
  }) : super(key: key);
  final LeadsProvider lp;

  @override
  State<LeadAssignmentToLeaderDialog> createState() =>
      _LeadAssignmentToLeaderDialogState();
}

class _LeadAssignmentToLeaderDialogState
    extends State<LeadAssignmentToLeaderDialog> {
  var leaderId;
  var sourceId;
  var statusId;
  final GlobalKey<FormState> _leaderKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _sourceKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _statusKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _dateKey = GlobalKey<FormState>();

  DateTime? date;
  TextEditingController dtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        height: Get.height * 0.6,
        width: Get.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Lead Assign To Team Leader",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  TestPage(
                    title: 'Team Leader',
                    list: widget.lp.teamLeadersList,
                    formKey: _leaderKey,
                    onTap: (id) {
                      setState(() {
                        leaderId = id;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TestPage(
                    formKey: _sourceKey,
                    title: 'Source',
                    list: widget.lp.sourcesList,
                    onTap: (id) {
                      setState(() {
                        sourceId = id;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TestPage(
                    formKey: _statusKey,
                    title: 'Status',
                    list: widget.lp.statusList,
                    onTap: (id) {
                      setState(() {
                        statusId = id;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Date',
                        style: Get.theme.textTheme.bodyText1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Form(
                    key: _dateKey,
                    child: TextFormField(
                      readOnly: true,
                      onTap: () async {
                        var dt = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)));
                        if (dt != null) {
                          date = dt;
                          dtController.text =
                              DateFormat('yyyy-MM-dd').format(dt);

                          print(date);
                          setState(() {});
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required field";
                        } else {
                          return null;
                        }
                      },
                      controller: dtController,
                      decoration: InputDecoration(
                          hintText: 'Select Date',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Close'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () async {
                    // lp.dispose();
                    if (_leaderKey.currentState!.validate() &&
                        _sourceKey.currentState!.validate() &&
                        _statusKey.currentState!.validate() &&
                        _dateKey.currentState!.validate()) {
                      await widget.lp.assignToTeamLeader();
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
          ],
        ),
      );
    });
  }
}

class LeadAssignmentToAgentDialog extends StatefulWidget {
  const LeadAssignmentToAgentDialog({
    Key? key,
    required this.lp,
  }) : super(key: key);
  final LeadsProvider lp;

  @override
  State<LeadAssignmentToAgentDialog> createState() =>
      _LeadAssignmentToAgentDialogState();
}

class _LeadAssignmentToAgentDialogState
    extends State<LeadAssignmentToAgentDialog> {
  var agentId;
  var sourceId;
  var statusId;
  final GlobalKey<FormState> _agentKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _sourceKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _statusKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _dateKey = GlobalKey<FormState>();

  DateTime? date;
  TextEditingController agentsController = TextEditingController();
  TextEditingController dtController = TextEditingController();
  List<AgentById> agents = [];
  AgentById? selectedAgent;
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  SimpleAutoCompleteTextField? textField;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        height: Get.height * 0.6,
        width: Get.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Lead Assign To Agents",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Agents',
                        style: Get.theme.textTheme.bodyText1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Form(
                    key: _agentKey,
                    child: TextFormField(
                      readOnly: true,
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: SizedBox(
                                  width: Get.width * 0.6,
                                  height: Get.height * 0.4,
                                  child: Column(children: <Widget>[
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                          color: Colors.white,
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                hintText: 'Search here'),
                                          ),
                                        ))
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AgentsList(
                                          selectedAgent: selectedAgent,
                                          onTap: (agent) {
                                            setState(() {
                                              selectedAgent = agent;
                                              agentsController.text =
                                                  agent.name!;
                                              Get.back();
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              );
                            });
                      },
                      controller: agentsController,
                      decoration: InputDecoration(
                          hintText: 'Select',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                selectedAgent = null;
                                agentsController.text = '';
                              });
                            },
                            icon: const Icon(Icons.clear),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required field";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  TestPage(
                    formKey: _sourceKey,
                    title: 'Sources',
                    list: widget.lp.sourcesList,
                    onTap: (id) {
                      setState(() {
                        sourceId = id;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TestPage(
                    formKey: _statusKey,
                    title: 'Status',
                    list: widget.lp.statusList,
                    onTap: (id) {
                      setState(() {
                        statusId = id;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Date',
                        style: Get.theme.textTheme.bodyText1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Form(
                    key: _dateKey,
                    child: TextFormField(
                      readOnly: true,
                      onTap: () async {
                        var dt = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)));
                        if (dt != null) {
                          date = dt;
                          dtController.text =
                              DateFormat('yyyy-MM-dd').format(dt);
                          setState(() {});
                        }
                      },
                      controller: dtController,
                      decoration: InputDecoration(
                          hintText: 'Select Date',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                date = null;
                                dtController.text = '';
                              });
                            },
                            icon: const Icon(Icons.clear),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required field";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Close'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () async {
                    if (_agentKey.currentState!.validate() &&
                        _sourceKey.currentState!.validate() &&
                        _statusKey.currentState!.validate() &&
                        _dateKey.currentState!.validate()) {
                      await widget.lp.assignToAgent();
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
          ],
        ),
      );
    });
  }
}

class AgentsList extends StatefulWidget {
  const AgentsList({Key? key, required this.onTap, this.selectedAgent})
      : super(key: key);
  final void Function(AgentById agent) onTap;
  final AgentById? selectedAgent;

  @override
  State<AgentsList> createState() => _AgentsListState();
}

class _AgentsListState extends State<AgentsList> {
  AgentById? selectedAgent;
  @override
  void initState() {
    super.initState();
    if (widget.selectedAgent != null) {
      selectedAgent = widget.selectedAgent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LeadsProvider>(builder: (context, lp, _) {
      return ListView(
        children: [
          if (lp.role != UserType.admin.name)
            ...lp.agentsByTeamList.map(
              (e) {
                return Container(
                  color: Colors.white,
                  child: ExpansionTile(
                    collapsedBackgroundColor: Colors.white,
                    title: Text(e.name!),
                    children: [
                      ...e.agents!.map(
                        (agent) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, left: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: selectedAgent == agent
                                  ? themeColor.withOpacity(0.1)
                                  : Colors.white,
                            ),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              tileColor: selectedAgent == agent
                                  ? themeColor.withOpacity(0.1)
                                  : Colors.white,
                              onTap: () {
                                setState(() {
                                  selectedAgent = agent;
                                  widget.onTap(selectedAgent!);
                                });
                              },
                              title: Text(agent.name!),
                            ),
                          ),
                        ),
                      ),
                    ],
                    // child: Text(e.name!),
                  ),
                );
              },
            ),
          if (lp.role == UserType.admin.name)
            ...lp.agentsByIdList.map(
              (e) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    tileColor: themeColor.withOpacity(0.1),
                    onTap: () {
                      setState(() {
                        selectedAgent = e;
                        widget.onTap(selectedAgent!);
                      });
                    },
                    title: Text(e.name!),
                  ),
                );
              },
            ),
        ],
      );
    });
  }
}

class TestPage extends StatefulWidget {
  const TestPage({
    Key? key,
    required this.title,
    required this.list,
    required this.onTap,
    required this.formKey,
    this.textColor,
    this.textStyle,
    this.fieldRadius,
  }) : super(key: key);
  final String? title;
  final List list;
  final Color? textColor;
  final TextStyle? textStyle;
  final double? fieldRadius;
  final GlobalKey<FormState> formKey;
  final void Function(int id) onTap;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late SingleValueDropDownController _cnt;

  @override
  void initState() {
    _cnt = SingleValueDropDownController();
    super.initState();
  }

  @override
  void dispose() {
    _cnt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.title ?? '',
                style: widget.textStyle ??
                    Get.theme.textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold, color: widget.textColor),
              ),
            ],
          ),
          const SizedBox(height: 5),
          DropDownTextField(
            controller: _cnt,
            clearOption: true,
            enableSearch: true,
            textStyle: TextStyle(color: widget.textColor),
            textFieldDecoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: widget.textColor ?? Colors.black),
                  borderRadius: BorderRadius.all(
                      Radius.circular(widget.fieldRadius ?? 4.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: widget.textColor ?? Colors.black),
                  borderRadius: BorderRadius.all(
                      Radius.circular(widget.fieldRadius ?? 4.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: widget.textColor ?? Colors.black),
                  borderRadius: BorderRadius.all(
                      Radius.circular(widget.fieldRadius ?? 4.0)),
                ),
                hintText: 'Select',
                hintStyle: TextStyle(color: widget.textColor)),
            searchDecoration: const InputDecoration(hintText: "Search here"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Required field";
              } else {
                return null;
              }
            },
            dropDownIconProperty:
                IconProperty(color: widget.textColor ?? Colors.black),
            dropDownItemCount: 5,
            dropDownList: [
              ...widget.list.map((e) {
                return DropDownValueModel(
                    name: e.name, value: e.id, toolTipMsg: e.name);
              }),
            ],
            onChanged: (val) {
              widget.onTap(val.value.runtimeType == 1.runtimeType
                  ? val.value
                  : int.parse(val.value));
            },
          ),
        ],
      ),
    );
  }
}

class LeadsFilters extends StatefulWidget {
  const LeadsFilters({
    Key? key,
    required this.token,
    this.selectedIndex,
  }) : super(key: key);
  final String token;
  final int? selectedIndex;

  @override
  State<LeadsFilters> createState() => _LeadsFiltersState();
}

class _LeadsFiltersState extends State<LeadsFilters> {
  int selectedIndex = 0;
  List<AgentById> agentsByIdList = [];
  List<DeveloperModel> developersList = [];
  List<PropertyModel> propertyList = [];
  List<StatusModel> statusList = [];
  List<SourceModel> sourcesList = [];
  List<String> priorityList = [];
  List<String> prodList = [];

  void init() {
    var lp = Provider.of<LeadsProvider>(context, listen: false);
    agentsByIdList = lp.agentsByIdList;
    developersList = lp.developersList;
    propertyList = lp.propertyList;
    statusList = lp.statusList;
    sourcesList = lp.sourcesList;
    priorityList = lp.priorityList;
    prodList = lp.prodList;
    if (widget.selectedIndex != null) {
      selectedIndex = widget.selectedIndex!;
    }
    lp.selectedProd ??= "All";
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LeadsProvider>(builder: (context, lp, _) {
      return Scaffold(
        appBar: buildAppBar(),
        body: Row(
          children: [
            Expanded(flex: 2, child: filterLeftSection(lp)),
            VerticalDivider(width: 1, color: themeColor),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: selectedIndex == 0
                    ? agentsFilter(lp)
                    : selectedIndex == 1
                        ? dateFilter(lp, context)
                        : selectedIndex == 9
                            ? developerFilter(lp)
                            : selectedIndex == 9
                                ? propertyFilter(lp)
                                : selectedIndex == 2
                                    ? statusFilter(lp)
                                    : selectedIndex == 3
                                        ? sourcesFilter(lp)
                                        : selectedIndex == 4
                                            ? priorityFilter(lp)
                                            : selectedIndex == 5
                                                ? keywordFilter(lp)
                                                : selectedIndex == 6
                                                    ? bktFilter(lp)
                                                    : prodFilter(lp),
              ),
            ),
          ],
        ),
        bottomNavigationBar: bottomApplyAndClearFilter(lp),
      );
    });
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      title: Text('Filters', style: Get.theme.textTheme.headline6),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  bottomApplyAndClearFilter(LeadsProvider lp) {
    return Container(
      color: Colors.white,
      height: 70,
      child: Column(
        children: [
          const Divider(height: 1, thickness: 1),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () async {
                    lp.isFilterApplied(false);
                    Get.back();
                    await lp.applyFilter(lp);
                    Future.delayed(const Duration(seconds: 1), () {});
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.clear,
                        size: 13,
                      ),
                      Text(' Clear Filters'),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () async {
                    Get.back();
                    await lp.applyFilter(lp);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28.0),
                    child: Text(
                      'Apply',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column prodFilter(LeadsProvider lp) {
    return Column(
      children: [
        TextFormField(
          controller: lp.queryProd,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          onChanged: (val) {
            if (val.isNotEmpty) {
              var list = filterSearchResult(
                  lp.prodList
                      .map((e) => MapEntry(lp.prodList.indexOf(e), e))
                      .toList(),
                  val);
              setState(() {
                prodList = list.map((e) => e.value).toList();
              });
            } else {
              setState(() {
                prodList = lp.prodList;
                lp.queryProd.text = '';
              });
            }
          },
        ),
        const SizedBox(height: 10),
        const Divider(),
        ...prodList.map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: RadioListTile<String>(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              tileColor: themeColor.withOpacity(0.1),
              value: e,
              groupValue: lp.selectedProd,
              onChanged: (val) {
                setState(() {
                  lp.selectedProd = val!;
                  lp.queryProd.text = e;
                });
              },
              title: Text(e),
            ),
          ),
        )
      ],
    );
  }

  Column bktFilter(LeadsProvider lp) {
    return Column(
      children: [
        TextFormField(
          controller: lp.queryBkt,
          decoration: InputDecoration(
              hintText: 'Search By BKT Number',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          onChanged: (val) {
            setState(() {
              lp.queryBkt.text = val;
            });
          },
        ),
      ],
    );
  }

  Column keywordFilter(LeadsProvider lp) {
    return Column(
      children: [
        TextFormField(
          controller: lp.query,
          decoration: InputDecoration(
              hintText: 'Search By Words',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          onChanged: (val) {
            setState(() {
              lp.query.text = val;
            });
          },
        ),
      ],
    );
  }

  Column priorityFilter(LeadsProvider lp) {
    return Column(
      children: [
        TextFormField(
          controller: lp.queryPriority,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          onChanged: (val) {
            if (val.isNotEmpty) {
              var list = filterSearchResult(
                  lp.priorityList
                      .map((e) => MapEntry(lp.priorityList.indexOf(e), e))
                      .toList(),
                  val);
              setState(() {
                priorityList = list.map((e) => e.value).toList();
              });
            } else {
              setState(() {
                priorityList = lp.priorityList;
                lp.queryPriority.text = '';
              });
            }
          },
        ),
        const SizedBox(height: 10),
        const Divider(),
        ...priorityList.map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: RadioListTile<String>(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              tileColor: themeColor.withOpacity(0.1),
              value: e,
              groupValue: lp.selectedPriority,
              onChanged: (val) {
                setState(() {
                  lp.selectedPriority = val!;
                  lp.queryPriority.text = e;
                });
              },
              title: Text(e),
            ),
          ),
        )
      ],
    );
  }

  Column sourcesFilter(LeadsProvider lp) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            children: [
              TextFormField(
                controller: lp.querySources,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    var list = filterSearchResult(
                        lp.sourcesList
                            .map((e) => MapEntry(e.id!, e.name!))
                            .toList(),
                        val);
                    setState(() {
                      sourcesList = list
                          .map((e) => SourceModel(
                                id: e.key,
                                name: e.value,
                              ))
                          .toList();
                    });
                  } else {
                    setState(() {
                      sourcesList = lp.sourcesList;
                      lp.querySources.text = '';
                    });
                  }
                },
              ),
              const SizedBox(height: 10),
              CheckboxListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                tileColor: themeColor.withOpacity(0.1),
                value:
                    lp.multiSelectedSources.length == lp.sourcesList.length ||
                        lp.multiSelectedSources.isEmpty,
                onChanged: (bool? val) {
                  setState(() {
                    if (val!) {
                      lp.multiSelectedSources.clear();
                      lp.multiSelectedSources.addAll(lp.sourcesList);
                    } else {
                      lp.multiSelectedSources = [];
                    }
                    if (lp.multiSelectedSources.length ==
                            lp.sourcesList.length ||
                        lp.multiSelectedSources.isEmpty) {
                      lp.querySources.text = 'All';
                    } else {
                      lp.querySources.text = '';
                    }
                  });
                },
                title: const Text('All'),
              ),
              const Divider(),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              ...sourcesList.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CheckboxListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    tileColor: themeColor.withOpacity(0.1),
                    value: lp.multiSelectedSources.contains(e),
                    // groupValue: true,
                    onChanged: (val) {
                      setState(() {
                        if (val!) {
                          lp.multiSelectedSources.add(e);
                        } else {
                          lp.multiSelectedSources.remove(e);
                        }
                        if (lp.multiSelectedSources.length ==
                                lp.sourcesList.length ||
                            lp.multiSelectedSources.isEmpty) {
                          lp.querySources.text = 'All';
                        } else {
                          lp.querySources.text = '';
                        }
                      });
                    },
                    title: Text(e.name!),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column statusFilter(LeadsProvider lp) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            children: [
              TextFormField(
                controller: lp.queryStatus,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    var list = filterSearchResult(
                        lp.statusList
                            .map((e) => MapEntry(e.id!, e.name!))
                            .toList(),
                        val);
                    setState(() {
                      statusList = list
                          .map((e) => StatusModel(
                                id: e.key,
                                name: e.value,
                              ))
                          .toList();
                    });
                  } else {
                    setState(() {
                      statusList = lp.statusList;
                      lp.queryStatus.text = '';
                    });
                  }
                },
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: themeColor.withOpacity(0.1),
                ),
                child: CheckboxListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  tileColor: themeColor.withOpacity(0.1),
                  value:
                      lp.multiSelectedStatus.length == lp.statusList.length ||
                          lp.multiSelectedStatus.isEmpty,
                  onChanged: (bool? val) {
                    setState(() {
                      if (val!) {
                        lp.multiSelectedStatus.clear();
                        lp.multiSelectedStatus.addAll(lp.statusList);
                      } else {
                        lp.multiSelectedStatus = [];
                      }
                      if (lp.multiSelectedStatus.length ==
                              lp.statusList.length ||
                          lp.multiSelectedStatus.isEmpty) {
                        lp.queryStatus.text = 'All';
                      } else {
                        lp.queryStatus.text = '';
                      }
                    });
                  },
                  title: const Text('All'),
                ),
              ),
              const Divider(),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              ...statusList.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CheckboxListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    tileColor: themeColor.withOpacity(0.1),
                    value: lp.multiSelectedStatus.contains(e),
                    onChanged: (val) {
                      setState(() {
                        if (val!) {
                          lp.multiSelectedStatus.add(e);
                        } else {
                          lp.multiSelectedStatus.remove(e);
                        }
                        if (lp.multiSelectedStatus.length ==
                                lp.statusList.length ||
                            lp.multiSelectedStatus.isEmpty) {
                          lp.queryStatus.text = 'All';
                        } else {
                          lp.queryStatus.text = '';
                        }
                      });
                    },
                    title: Text(e.name!),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column propertyFilter(LeadsProvider lp) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            children: [
              TextFormField(
                controller: lp.queryProperty,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    var list = filterSearchResult(
                        lp.propertyList
                            .map((e) => MapEntry(e.id!, e.name!))
                            .toList(),
                        val);
                    setState(() {
                      propertyList = list
                          .map((e) => PropertyModel(
                                id: e.key,
                                name: e.value,
                              ))
                          .toList();
                    });
                  } else {
                    setState(() {
                      propertyList = lp.propertyList;
                      lp.queryProperty.text = '';
                    });
                  }
                },
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    color: themeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5)),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  tileColor: themeColor.withOpacity(0.1),
                  onTap: () {
                    setState(() {
                      lp.selectedProperty = null;
                      lp.queryProperty.text = 'All';
                    });
                  },
                  leading: const Text(''),
                  title: const Text('All'),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            // color: Colors.white,
            child: ListView(
              children: [
                const Divider(),
                ...propertyList.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: RadioListTile<int>(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      tileColor: themeColor.withOpacity(0.1),
                      value: e.id!,
                      groupValue: lp.selectedProperty,
                      onChanged: (val) {
                        setState(() {
                          // if (lp.selectedAgent==e) {
                          lp.selectedProperty = val!;
                          lp.queryProperty.text = e.name!;
                        });
                      },
                      title: Text(e.name!),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column developerFilter(LeadsProvider lp) {
    return Column(
      children: [
        TextFormField(
          controller: lp.queryDevelopers,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          onChanged: (val) {
            if (val.isNotEmpty) {
              var list = filterSearchResult(
                  lp.developersList
                      .map((e) => MapEntry(e.id!, e.name!))
                      .toList(),
                  val);
              setState(() {
                developersList = list
                    .map((e) => DeveloperModel(
                          id: e.key,
                          name: e.value,
                        ))
                    .toList();
              });
            } else {
              setState(() {
                developersList = lp.developersList;
                lp.queryDevelopers.text = '';
              });
            }
          },
        ),
        const SizedBox(height: 10),
        ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          tileColor: themeColor.withOpacity(0.1),
          onTap: () {
            setState(() {
              lp.selectedDeveloper = null;
              lp.queryDevelopers.text = 'All';
            });
          },
          leading: const Text(''),
          title: const Text('All'),
        ),
        const Divider(),
        Expanded(
          child: ListView(
            children: [
              ...developersList.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: RadioListTile<int>(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    tileColor: themeColor.withOpacity(0.1),
                    value: e.id!,
                    groupValue: lp.selectedDeveloper,
                    onChanged: (val) {
                      setState(() {
                        lp.selectedDeveloper = val;
                        lp.queryDevelopers.text = e.name!;
                      });
                    },
                    title: Text(e.name!),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  dateFilter(LeadsProvider lp, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'From Date',
          style: Get.theme.textTheme.headline6,
        ),
        const SizedBox(height: 10),
        TextFormField(
          readOnly: true,
          // controller: TextEditingController(),
          decoration: InputDecoration(
              hintText: lp.fromDate != null
                  ? DateFormat('yyyy-MM-dd').format(lp.fromDate!)
                  : 'From',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          onTap: () async {
            var date = await showDatePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                initialDate: lp.fromDate ?? DateTime.now());
            if (date != null) {
              setState(() {
                lp.fromDate = date;
                // lp.toDate = dateRange.end;
              });
            }
          },
        ),
        const Divider(),
        Text(
          'To Date',
          style: Get.theme.textTheme.headline6,
        ),
        const SizedBox(height: 10),
        TextFormField(
          readOnly: true,
          controller: TextEditingController(),
          decoration: InputDecoration(
              hintText: lp.toDate != null
                  ? DateFormat('yyyy-MM-dd').format(lp.toDate!)
                  : "To",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          onTap: () async {
            var date = await showDatePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                initialDate: lp.toDate ?? DateTime.now());
            if (date != null) {
              setState(() {
                lp.toDate = date;
                // lp.toDate = dateRange.end;
              });
            }
          },
        ),
      ],
    );
  }

  Column agentsFilter(LeadsProvider lp) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            children: [
              if (lp.role == UserType.admin.name)
                TextFormField(
                  controller: lp.queryAgents,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onChanged: (val) async {
                    if (val.isNotEmpty) {
                      // List<MapEntry<int, String>> ls = [];
                      // // print(lp.role == UserType.admin.name);
                      // if (lp.role != UserType.admin.name) {
                      //   for (var e in lp.agentsByTeamList) {
                      //     // print('user role ${lp.role}');
                      //
                      //     // print(e);
                      //     for (var element in e.agents!) {
                      //       ls.add(MapEntry(
                      //           int.parse(element.id!),
                      //           element.name!));
                      //     }
                      //   }
                      //   print('ls length' +
                      //       ls.length.toString());
                      // }
                      // // ls.map((e) => print(e));
                      var list = filterSearchResult(
                          // lp.role != UserType.admin.name
                          //     ? ls
                          lp.agentsByIdList
                              .map((e) => MapEntry(int.parse(e.id!), e.name!))
                              .toList(),
                          val);
                      setState(() {
                        // agentsByTeamList = list
                        //     .map((e) => AgentsByTeam(name: lp.agentsByTeamList.firstWhere((element) => element.agents!.any((element) => element.id==e.key.toString())).name,agents: list.where((element) => lp.agentsByTeamList.firstWhere((element) => element.agents!.any((element) => element.id==e.key.toString())).agents.map((e) => AgentById(
                        //   id: e.key.toString(),
                        //   name: e.value,
                        // )).toList()))))
                        //     .toList();
                        agentsByIdList = list
                            .map((e) => AgentById(
                                  id: e.key.toString(),
                                  name: e.value,
                                ))
                            .toList();
                      });
                    } else {
                      setState(() {
                        agentsByIdList = lp.agentsByIdList;
                        lp.queryAgents.text = '';
                      });
                    }
                  },
                ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: themeColor.withOpacity(0.1),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  tileColor: themeColor.withOpacity(0.1),
                  onTap: () {
                    setState(() {
                      lp.selectedAgent = null;
                      lp.queryAgents.text = 'All';
                    });
                  },
                  leading: const Text(''),
                  title: const Text('All'),
                ),
              ),
              const Divider(),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              if (lp.role != UserType.admin.name)
                ...lp.agentsByTeamList.map(
                  (e) => Container(
                    color: Colors.white,
                    child: ExpansionTile(
                      collapsedBackgroundColor: Colors.white,
                      title: Text(e.name!),
                      children: [
                        ...e.agents!.map(
                          (agent) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: themeColor.withOpacity(0.1),
                              ),
                              child: RadioListTile<String>(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                tileColor: themeColor.withOpacity(0.1),
                                value: agent.id!,
                                groupValue: lp.selectedAgent,
                                onChanged: (val) {
                                  setState(() {
                                    lp.selectedAgent = val!;
                                    lp.queryAgents.text = agent.name!;
                                  });
                                },
                                title: Text(agent.name!),
                              ),
                            ),
                          ),
                        ),
                      ],
                      // child: Text(e.name!),
                    ),
                  ),
                ),
              if (lp.role == UserType.admin.name)
                ...agentsByIdList.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: RadioListTile<String>(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      tileColor: themeColor.withOpacity(0.1),
                      value: e.id!,
                      groupValue: lp.selectedAgent,
                      onChanged: (val) {
                        setState(() {
                          lp.selectedAgent = val!;
                          lp.queryAgents.text = e.name!;
                        });
                      },
                      title: Text(e.name!),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  ListView filterLeftSection(LeadsProvider lp) {
    return ListView(
      children: [
        ...lp.categoriesList.map(
          (e) => Column(
            children: [
              Stack(
                children: [
                  ListTile(
                    tileColor: selectedIndex == lp.categoriesList.indexOf(e)
                        ? themeColor.withOpacity(0.1)
                        : null,
                    onTap: () {
                      setState(() {
                        selectedIndex = lp.categoriesList.indexOf(e);
                      });
                    },
                    title: SizedBox(
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e,
                            style: TextStyle(
                                color: selectedIndex ==
                                        lp.categoriesList.indexOf(e)
                                    ? Get.theme.primaryColor
                                    : null),
                          ),
                        ],
                      ),
                    ),
                    trailing: Text(
                      e == lp.categoriesList[0] && lp.selectedAgent != null
                          ? 1.toString()
                          : e == lp.categoriesList[1] &&
                                  (lp.fromDate != null || lp.toDate != null)
                              ? '🔘'
                              // : e == lp.categoriesList[9] &&
                              //         lp.selectedDeveloper != null
                              //     ? 1.toString()
                              //     : e == lp.categoriesList[3] &&
                              //             lp.selectedProperty != null
                              //         ? 1.toString()
                              : e == lp.categoriesList[2] &&
                                      lp.multiSelectedStatus.isNotEmpty
                                  ? lp.multiSelectedStatus.length.toString()
                                  : e == lp.categoriesList[3] &&
                                          lp.multiSelectedSources.isNotEmpty
                                      ? lp.multiSelectedSources.length
                                          .toString()
                                      : e == lp.categoriesList[4] &&
                                              lp.selectedPriority != null
                                          ? 1.toString()
                                          : e == lp.categoriesList[5] &&
                                                  lp.query.text.isNotEmpty
                                              ? '💤'
                                              : e == lp.categoriesList[6] &&
                                                      lp.queryBkt.text.isNotEmpty
                                                  ? lp.queryBkt.text
                                                  : e == lp.categoriesList[7] &&
                                                          lp.selectedProd !=
                                                              null &&
                                                          lp.selectedProd !=
                                                              'All'
                                                      ? lp.selectedProd!
                                                      : '',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        color: selectedIndex == lp.categoriesList.indexOf(e)
                            ? themeColor.withOpacity(1)
                            : null,
                        width: 7,
                        height: 58,
                      ),
                    ],
                  ),
                ],
              ),
              Divider(thickness: 0.1, color: themeColor, height: 1),
            ],
          ),
        ),
      ],
    );
  }
}
