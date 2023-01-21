import 'dart:io';

import 'package:crm_application/Provider/LeadsProvider.dart';
import 'package:crm_application/Screens/Cold%20Calls/MyLeads/TestCallDetailsScreen/CompleteleadProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Models/LeadsModel.dart';
import '../../../../Utils/Colors.dart';
import 'AddLeadNoteScreen.dart';
import 'LeadDetailsScreen.dart';
import 'LeadNotesScreen.dart';
import 'ScheduledCall.dart';

// class TestCallScreen extends StatefulWidget {
//   /* String leadId,
//       leadName,
//       Name,
//       leadDate,
//       leadContact,
//       leadAltContact,
//       leadEmail,
//       avg_amount,
//       authToken;
//   List<NewComment> notes;*/
//
//   String leadId;
// final Lead lead;
//   TestCallScreen({
//     Key? key,
//     required this.lead,
//     required this.leadId,
//     /*required this.leadId,
//     required this.leadName,
//     required this.Name,
//     required this.leadDate,
//     required this.leadContact,
//     required this.leadAltContact,
//     required this.leadEmail,
//     required this.notes,
//     required this.avg_amount,
//     required this.authToken,*/
//   }) : super(key: key);
//
//   @override
//   State<TestCallScreen> createState() => _TestCallScreenState();
// }
//
// class _TestCallScreenState extends State<TestCallScreen> {
//   var whatsapp, message;
//   String TAG = 'TestCallScreen';
//   List<LeadInfo> _leadInfoList = [];
//   late SharedPreferences pref;
//   bool _isLoading = true;
//   var authToken,
//       leadId = '',
//       leadName = '',
//       Name = '',
//       leadDate = '',
//       leadContact = '',
//       leadAltContact = '',
//       leadEmail = '',
//       avg_amount = '',
//       leadSource = '',
//       sourceName = '',
//       statusName = '',
//       sourceId = '',
//       statusId = '',
//       assigndUser1 = '',
//       assigndUser = '';
//   List<NewComment> notes = [];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //leadAltContact = widget.leadAltContact;
//     debugPrint('$TAG LeadID: ${widget.leadId}');
//     getPrefs();
//   }
//
//   void getPrefs() async {
//     pref = await SharedPreferences.getInstance();
//     authToken = pref.getString('token');
//     debugPrint("authToken: " + authToken);
//     debugPrint("LeadId: " + widget.leadId);
//     getLeadInfo();
//     setState((){});
//   }
//
//   void getLeadInfo() async {
//     _leadInfoList.clear();
//     var url = '${ApiManager.BASE_URL}${ApiManager.getLead}/${widget.leadId}';
//     final headers = {
//       'Authorization-token': ApiManager.Authorization_token,
//       'Authorization': 'Bearer $authToken',
//     };
//     try {
//       final response = await http.get(Uri.parse(url), headers: headers);
//       var responseData = json.decode(response.body);
//       log('LeadInfo : ${responseData.toString()}');
//       if (response.statusCode == 200) {
//         var success = responseData['success'];
//         var leadInfoList = responseData['data'];
//         if (success == 200) {
//           _isLoading = false;
//
//           leadInfoList.forEach((v) {
//             _leadInfoList.add(LeadInfo.fromJson(v));
//           });
//           setState(() {
//             leadId = _leadInfoList[0].lead!.id.toString();
//             leadName = _leadInfoList[0].lead!.name.toString();
//             leadEmail = _leadInfoList[0].lead!.email.toString();
//             leadContact = _leadInfoList[0].lead!.phone.toString();
//             leadDate = _leadInfoList[0].lead!.date.toString();
//             avg_amount = _leadInfoList[0].lead!.avgIncome.toString();
//             notes = _leadInfoList[0].lead!.newComments;
//             leadSource = _leadInfoList[0].lead!.sources!.name.toString();
//             sourceName = _leadInfoList[0].lead!.sources!.name.toString();
//             statusName = _leadInfoList[0].lead!.statuses!=null?_leadInfoList[0].lead!.statuses!.name!:'';
//             sourceId = _leadInfoList[0].lead!.sources!.id.toString();
//             statusId = _leadInfoList[0].lead!.statuses!=null?_leadInfoList[0].lead!.statuses!.id.toString():'';
//
//             assigndUser =
//                 '${_leadInfoList[0].lead!.agents![0].firstName.toString()} ${_leadInfoList[0].lead!.agents![0].lastName.toString()}';
//           });
//         }
//       } else {
//         _isLoading = false;
//         throw const HttpException('Failed To get Leads');
//       }
//     } catch (error) {
//       rethrow;
//     }
//   }
//
//   void SendTestimonialMail() async {
//     var url = 'http://axtech.range.ae/api/v1/askTestimonial/${widget.leadId}';
//     final headers = {
//       'Authorization-token': '3MPHJP0BC63435345341',
//       'Authorization': 'Bearer $authToken',
//     };
//     try {
//       final response = await http.get(Uri.parse(url), headers: headers);
//       var responseData = json.decode(response.body);
//       debugPrint("Response :${responseData.toString()}");
//       if (response.statusCode == 200) {
//         var success = responseData['success'];
//         /* if (success == true) {
//           Navigator.pop(context);
//           debugPrint("$TAG Success : ${response.body}");
//         }*/
//         Navigator.pop(context);
//         debugPrint("$TAG Success : ${response.body}");
//       } else {
//         Navigator.pop(context);
//         throw const HttpException('Failed To Add note');
//       }
//     } catch (error) {
//       rethrow;
//     }
//   }
//
//   void SendReferalMail() async {
//     var url = 'http://axtech.range.ae/api/v1/askReferal/${widget.leadId}';
//     final headers = {
//       'Authorization-token': '3MPHJP0BC63435345341',
//       'Authorization': 'Bearer $authToken',
//     };
//     try {
//       final response = await http.get(Uri.parse(url), headers: headers);
//       var responseData = json.decode(response.body);
//       debugPrint(responseData.toString());
//       if (response.statusCode == 200) {
//         var success = responseData['success'];
//         message = responseData['message'];
//         if (success == 200) {
//           Navigator.pop(context);
//           debugPrint("$TAG Success : ${response.body}");
//         } else if (success == 401) {
//           Navigator.pop(context);
//           ScaffoldMessenger.of(context)
//               .showSnackBar(SnackBar(content: Text(message)));
//         }
//         Navigator.pop(context);
//         debugPrint("$TAG Success : ${response.body}");
//       } else {
//         Navigator.pop(context);
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text(message)));
//         throw const HttpException('Failed To Add note');
//       }
//     } catch (error) {
//       rethrow;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: themeColor,
//         elevation: 1,
//         titleSpacing: 0,
//         title: Text(leadName),
//         actions: [],
//       ),
//       body: !_isLoading
//           ? SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Lead ID : $leadId',
//                               style: const TextStyle(fontWeight: FontWeight.w400),
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     leadName,
//                                     style: const TextStyle(
//                                         fontWeight: FontWeight.bold, fontSize: 20),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     'Source : $sourceName',
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     softWrap: true,
//                                     style: const TextStyle(fontWeight: FontWeight.w400),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                              "Lead Date : "+ DateFormat('yyyy-MM-dd').format(DateTime.parse(
//                                   DateTime.now().toString())), //'2022-04-20 16:20:32',
//                               style: const TextStyle(fontWeight: FontWeight.w400),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                   Divider(
//                     color: themeColor,
//                     thickness: 1,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             // openWhatsapp('971581546367');
//                             // openWhatsapp('971927632972');
//                             openWhatsapp(leadContact);
//                           },
//                           child: Column(
//                             children: [
//                               const Icon(
//                                 Icons.whatsapp_outlined,
//                                 size: 40,
//                                 color: Colors.greenAccent,
//                               ),
//                               SizedBox(
//                                 height: 5.h,
//                               ),
//                               const Text('Whatsapp'),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           height: 65.h,
//                           width: 1,
//                           color: Colors.black,
//                         ),
//                         InkWell(
//                           onTap: () {
//                             /*Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => AddLeadNoteScreen(
//                                   leadId: widget.leadId,
//                                   leadName: widget.leadName,
//                                 ),
//                               ),
//                             );*/
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => CompleteLeadProfile(
//                                       leadId: widget.leadId,
//                                       leadName: leadName),
//                                 ));
//                           },
//                           child: Column(
//                             children: [
//                               Image.asset(
//                                 'assets/images/addNote.png',
//                                 height: 40,
//                               ),
//                               SizedBox(
//                                 height: 10.h,
//                               ),
//                               const Text('Change Status'),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           height: 65.h,
//                           width: 1,
//                           color: Colors.black,
//                         ),
//                         InkWell(
//                           onTap: () {
//                             _textMe();
//                           },
//                           child: Column(
//                             children: [
//                               const Icon(
//                                 Icons.message,
//                                 size: 40,
//                                 color: Colors.green,
//                               ),
//                               SizedBox(
//                                 height: 5.h,
//                               ),
//                               const Text('Messages'),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Divider(
//                     color: themeColor,
//                     thickness: 1,
//                   ),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   /* Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => AddLeadNoteScreen(
//                             leadId: widget.leadId,
//                             leadName: widget.leadName,
//                           ),
//                         ),
//                       );
//                       //showTestimonyDialog();
//                     },
//                     child: Container(
//                       height: 100,
//                       width: 110,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8),
//                         color: Colors.green,
//                       ),
//                       child: Column(
//                         children: const [
//                           SizedBox(
//                             height: 15,
//                           ),
//                           Icon(
//                             Icons.person,
//                             size: 40,
//                             color: Colors.white,
//                           ),
//                           SizedBox(
//                             height: 7,
//                           ),
//                           Text(
//                             'Add Comments',//"Ask Testimonial",
//                             style: TextStyle(color: Colors.white, fontSize: 13),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => CompleteleadProfile(leadId: widget.leadId,leadName: widget.leadName),));
//                     },
//                     child: Container(
//                       height: 100,
//                       width: 110,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8),
//                         color: themeColor,
//                       ),
//                       child: Column(
//                         children: const [
//                           SizedBox(
//                             height: 15,
//                           ),
//                           Icon(
//                             Icons.note_add,
//                             size: 40,
//                             color: Colors.white,
//                           ),
//                           SizedBox(
//                             height: 7,
//                           ),
//                           Text(
//                             "Complete Profile",
//                             style: TextStyle(color: Colors.white, fontSize: 13),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       showReferalDialog();
//                     },
//                     child: Container(
//                       height: 100,
//                       width: 110,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8),
//                         color: Colors.blue,
//                       ),
//                       child: Column(
//                         children: const [
//                           SizedBox(
//                             height: 15,
//                           ),
//                           Icon(
//                             Icons.star,
//                             size: 40,
//                             color: Colors.white,
//                           ),
//                           SizedBox(
//                             height: 7,
//                           ),
//                           Text(
//                             'Change Status',//"Ask Referal",
//                             style: TextStyle(color: Colors.white, fontSize: 13),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),*/
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   DefaultTabController(
//                     length: 3, // length of tabs
//                     initialIndex: 0,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           child: TabBar(
//                             indicator: BoxDecoration(
//                               borderRadius: BorderRadius.circular(
//                                 5.0,
//                               ),
//                               color: themeColor,
//                             ),
//                             labelColor: Colors.white,
//                             unselectedLabelColor: themeColor,
//                             tabs: const [
//                               Tab(text: 'Details'),
//                               Tab(text: 'Notes'),
//                               Tab(text: 'Schedules'),
//
//                               //Tab(text: 'History'),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 5, vertical: 10),
//                           child: Container(
//                             height: 400.h, //height of TabBarView
//                             decoration: const BoxDecoration(),
//                             child: TabBarView(
//                               children: <Widget>[
//                                 LeadDetailsScreen(
//                                   leadName: leadName,
//                                   leadId: widget.leadId,
//                                   leadAltContact: leadAltContact.isEmpty
//                                       ? 'No Alternate Number'
//                                       : leadAltContact,
//                                   leadContact: leadContact,
//                                   leadDate: leadDate,
//                                   Name: sourceName,
//                                   leadEmail: leadEmail,
//                                   avg_amount: avg_amount,
//                                   assignUser: assigndUser,
//                                   assigndUsers: assigndUser1,
//                                   agents: _leadInfoList[0].lead!.agents!,
//                                 ),
//                                 LeadNotesScreen(
//                                   notes: notes,
//                                   addCommentWidget: AddLeadNoteScreen(
//                                       leadId: leadId, leadName: leadName),
//                                 ),
//                                 ScheduledCall(
//                                     authToken: authToken, leadId: leadId),
//
//                                 // const AddLeadActivityScreen(),
//                                 //LeadHistoryScreen(leadId: widget.leadId),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : const Center(
//               child: CircularProgressIndicator(),
//             ),
//     );
//   }
//
//   void showTestimonyDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Ask Testimonials'),
//         content: const Text('Do you want to Email the Lead for Testimonials'),
//         actions: [
//           TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Cancel')),
//           TextButton(
//               onPressed: () {
//                 SendTestimonialMail();
//               },
//               child: const Text('Send Email')),
//         ],
//       ),
//     );
//   }
//
//   void showReferalDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Ask Testimonials'),
//         content: const Text('Do you want to Ask for Referal'),
//         actions: [
//           TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Cancel')),
//           TextButton(
//               onPressed: () {
//                 SendReferalMail();
//               },
//               child: const Text('Send Email')),
//         ],
//       ),
//     );
//   }
//
//   void openWhatsapp(String number) async {
//     whatsapp = '+$number';
//     print(whatsapp);
//
//     var whatsappURlAndroid = "whatsapp://send?phone=$whatsapp";
//     var whatappURLIos = "https://wa.me/$whatsapp";
//     if (Platform.isIOS) {
//       // for iOS phone only
//       if (await canLaunch(whatappURLIos)) {
//         await launch(whatappURLIos, forceSafariVC: false);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("whatsapp no installed")));
//       }
//     } else {
//       // android , web
//       if (await canLaunch(whatsappURlAndroid)) {
//         await launch(whatsappURlAndroid);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("whatsapp no installed")));
//       }
//     }
//   }
//
//   _textMe() async {
//     // Android
//     var uri = "sms:$leadContact?body=hello%20there";
//     if (await canLaunch(uri)) {
//       await launch(uri);
//     } else {
//       // iOS
//       var uri = 'sms:$leadContact?body=hello%20there';
//       if (await canLaunch(uri)) {
//         await launch(uri);
//       } else {
//         throw 'Could not launch $uri';
//       }
//     }
//   }
// }

class LeadDetail extends StatefulWidget {
  const LeadDetail({Key? key, required this.lead}) : super(key: key);
  final Lead lead;
  @override
  State<LeadDetail> createState() => _LeadDetailState();
}

class _LeadDetailState extends State<LeadDetail> {
  init() async {
    await Provider.of<LeadsProvider>(context, listen: false)
        .getLeadInfo(widget.lead.id!);
  }

  @override
  void initState() {
    super.initState();
    Provider.of<LeadsProvider>(context, listen: false).lead = widget.lead;
    init();
  }

  void _openWhatsapp(String number) async {
    var whatsapp = '+$number';
    print(whatsapp);

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
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("whatsapp no installed")));
      }
    }
  }

  _textMe(String number) async {
    // Android
    var uri = "sms:${number}?body=hello%20there";
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      var uri = 'sms:${number}body=hello%20there';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LeadsProvider>(builder: (context, lp, _) {
      if (lp.IsLoading) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.lead.customername ?? ''),
            backgroundColor: themeColor,
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        if (lp.lead != null) {
          var lead = lp.lead!;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: themeColor,
              elevation: 1,
              titleSpacing: 0,
              title: Text(lead.loanAgreementNo ?? ''),
            ),
            body: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  lead.customername ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Source : ${lead.sources != null ? lead.sources!.name : ''}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Lead Date : ${lead.date ?? ''}",
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Status : ${lead.status != null ? lp.statusList.firstWhere((element) => element.id == int.parse(lead.status!)).name : ''}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0),
                                child: InkWell(
                                  onTap: () async {
                                    await lp.modalBottomSheetMenu1(context);
                                  },
                                  child: const Icon(Icons.edit),
                                  splashColor: themeColor,
                                  radius: 30,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.h),
                const SizedBox(height: 10),
                Expanded(
                  child: DefaultTabController(
                    length: 3, // length of tabs
                    initialIndex: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TabBar(
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                5.0,
                              ),
                              color: themeColor,
                            ),
                            labelColor: Colors.white,
                            unselectedLabelColor: themeColor,
                            tabs: const [
                              Tab(text: 'Details'),
                              Tab(text: 'Notes'),
                              Tab(text: 'Schedules'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: TabBarView(
                              children: <Widget>[
                                FieldControl(
                                  lead: widget.lead,
                                  fieldControle: [
                                    [
                                      'Month',
                                      false,
                                      lp.lead!.month,
                                    ],
                                    [
                                      'Flow Recovery',
                                      false,
                                      lp.lead!.flowRecovery,
                                    ],
                                    [
                                      'DPD',
                                      false,
                                      lp.lead!.dpd,
                                    ],
                                    [
                                      'EMI Billed',
                                      false,
                                      lp.lead!.emiBilled,
                                    ],
                                    [
                                      'Secured Unsecured',
                                      false,
                                      lp.lead!.securedUnsecured,
                                    ],
                                    [
                                      'Bkt',
                                      false,
                                      lp.lead!.bkt,
                                    ],
                                    [
                                      'Actual Bkt',
                                      false,
                                      lp.lead!.actualBkt,
                                    ],
                                    [
                                      'Lmb Bkt',
                                      false,
                                      lp.lead!.lmbBkt,
                                    ],
                                    [
                                      'Tm Code',
                                      false,
                                      lp.lead!.tmCode,
                                    ],
                                    [
                                      'Branch',
                                      false,
                                      lp.lead!.branch,
                                    ],
                                    [
                                      'Branchid',
                                      false,
                                      lp.lead!.branchid,
                                    ],
                                    [
                                      'State name',
                                      false,
                                      lp.lead!.stateName,
                                    ],
                                    [
                                      'NCMS',
                                      false,
                                      lp.lead!.ncms,
                                    ],
                                    [
                                      'Repayment Mode',
                                      false,
                                      lp.lead!.repaymentMode,
                                    ],
                                    [
                                      'Collection Manager',
                                      false,
                                      lp.lead!.collectionManager,
                                    ],
                                    [
                                      'Cluster Manager',
                                      false,
                                      lp.lead!.clusterManager,
                                    ],
                                    [
                                      'State Manager',
                                      false,
                                      lp.lead!.stateManager,
                                    ],
                                    [
                                      'TM name',
                                      false,
                                      lp.lead!.tmName,
                                    ],
                                    [
                                      'RCMS',
                                      false,
                                      lp.lead!.rcms,
                                    ],
                                    [
                                      'Top 125',
                                      false,
                                      lp.lead!.top125,
                                    ],
                                    [
                                      'Category',
                                      false,
                                      lp.lead!.category,
                                    ],
                                    [
                                      'Agency cat',
                                      false,
                                      lp.lead!.agencyCat,
                                    ],
                                    [
                                      'Agency name with code',
                                      false,
                                      lp.lead!.agencyNameWithCode,
                                    ],
                                    [
                                      'FOS name',
                                      false,
                                      lp.lead!.fosName,
                                    ],
                                    [
                                      'E-Receipt Id',
                                      false,
                                      lp.lead!.eReceiptId,
                                    ],
                                    [
                                      'Mob Number',
                                      false,
                                      lp.lead!.mobNumber,
                                    ],
                                    [
                                      'Feedback',
                                      false,
                                      lp.lead!.feedback,
                                    ],
                                    [
                                      'Code',
                                      false,
                                      lp.lead!.code,
                                    ],
                                    [
                                      'Remove',
                                      false,
                                      lp.lead!.remove,
                                    ],
                                    [
                                      'Reason of bounce',
                                      false,
                                      lp.lead!.reasonOfBounce,
                                    ],
                                    [
                                      'Standard Reason',
                                      false,
                                      lp.lead!.standardReason,
                                    ],
                                    [
                                      'Asset Make',
                                      false,
                                      lp.lead!.assetMake,
                                    ],
                                    [
                                      'Registration No',
                                      false,
                                      lp.lead!.registrationNo,
                                    ],
                                    [
                                      'Product flag',
                                      false,
                                      lp.lead!.productflag,
                                    ],
                                    [
                                      'PROD',
                                      false,
                                      lp.lead!.prod,
                                    ],
                                    [
                                      'Loan Amount',
                                      false,
                                      lp.lead!.loanAmount,
                                    ],
                                    [
                                      'Loan Booking Date',
                                      false,
                                      lp.lead!.loanBookingDate,
                                    ],
                                    [
                                      'Disbursal Date',
                                      false,
                                      lp.lead!.disbursalDate,
                                    ],
                                    [
                                      'Due Date',
                                      false,
                                      lp.lead!.dueDate,
                                    ],
                                    [
                                      'EMI Amount',
                                      false,
                                      lp.lead!.emiAmount,
                                    ],
                                    [
                                      'EMI Due',
                                      false,
                                      lp.lead!.emiDue,
                                    ],
                                    [
                                      'Bounce Charge Due',
                                      false,
                                      lp.lead!.bounceChargeDue,
                                    ],
                                    [
                                      'LPP Due',
                                      false,
                                      lp.lead!.lppDue,
                                    ],
                                    [
                                      'TOS',
                                      false,
                                      lp.lead!.tos,
                                    ],
                                    [
                                      'POS',
                                      false,
                                      lp.lead!.pos,
                                    ],
                                    [
                                      'Coll Amt',
                                      false,
                                      lp.lead!.collAmt,
                                    ],
                                    [
                                      'DCR',
                                      false,
                                      lp.lead!.dcr,
                                    ],
                                    [
                                      'ROR Coll',
                                      false,
                                      lp.lead!.rorColl,
                                    ],
                                    [
                                      'Short',
                                      false,
                                      lp.lead!.short,
                                    ],
                                    [
                                      'PI Coll',
                                      false,
                                      lp.lead!.piColl,
                                    ],
                                    [
                                      'PGT',
                                      false,
                                      lp.lead!.pgt,
                                    ],
                                    [
                                      'Bist Status',
                                      false,
                                      lp.lead!.bistStatus,
                                    ],
                                    [
                                      'CLR',
                                      false,
                                      lp.lead!.clr,
                                    ],
                                    [
                                      'Status',
                                      false,
                                      lp.lead!.status,
                                    ],
                                    [
                                      'RB',
                                      false,
                                      lp.lead!.rb,
                                    ],
                                    [
                                      'SB',
                                      false,
                                      lp.lead!.sb,
                                    ],
                                    [
                                      'First EMI Due Date',
                                      false,
                                      lp.lead!.firstEmiDueDate,
                                    ],
                                    [
                                      'Allocation Date',
                                      false,
                                      lp.lead!.allocationDate,
                                    ],
                                    [
                                      'Scheme',
                                      false,
                                      lp.lead!.scheme,
                                    ],
                                    [
                                      'Supplier',
                                      false,
                                      lp.lead!.supplier,
                                    ],
                                    [
                                      'Tenure',
                                      false,
                                      lp.lead!.tenure,
                                    ],
                                    [
                                      'Reference Names',
                                      false,
                                      lp.lead!.referenceNames,
                                    ],
                                    [
                                      'Reference Names-2',
                                      false,
                                      lp.lead!.referenceNames2,
                                    ],
                                    [
                                      'Reference Names-3',
                                      false,
                                      lp.lead!.referenceNames3,
                                    ],
                                    [
                                      'Reference Address',
                                      false,
                                      lp.lead!.referenceAddress,
                                    ],
                                    [
                                      'Reference Address-2',
                                      false,
                                      lp.lead!.referenceAddress2,
                                    ],
                                    [
                                      'Reference Address-3',
                                      false,
                                      lp.lead!.referenceAddress3,
                                    ],
                                    [
                                      'Cust Ereceipt Mobile No',
                                      false,
                                      lp.lead!.custEreceiptMobileNo,
                                    ],
                                    [
                                      'customer Add Mobile',
                                      false,
                                      lp.lead!.customerAddMobile,
                                    ],
                                    [
                                      'Customer Add Phone-1',
                                      false,
                                      lp.lead!.customerAddPhone1,
                                    ],
                                    [
                                      'Customer Add Phone-2',
                                      false,
                                      lp.lead!.customerAddPhone2,
                                    ],
                                    [
                                      'Customer Address',
                                      false,
                                      lp.lead!.customerAddress,
                                    ],
                                    [
                                      'Cust Permanent Address',
                                      false,
                                      lp.lead!.custPermanentAddress,
                                    ],
                                    [
                                      'Cust Office Add Zipcode',
                                      false,
                                      lp.lead!.custOfficeAddZipcode,
                                    ],
                                    [
                                      'Cust Permanent Add Zipcode',
                                      false,
                                      lp.lead!.custPermanentAddZipcode,
                                    ],
                                    [
                                      'Primary Customer Fathername',
                                      false,
                                      lp.lead!.primaryCustomerFathername,
                                    ],
                                    [
                                      'Tech Non Tech',
                                      false,
                                      lp.lead!.techNonTech,
                                    ],
                                    [
                                      'Non Startercases',
                                      false,
                                      lp.lead!.nonstartercases,
                                    ],
                                    [
                                      'Zone',
                                      false,
                                      lp.lead!.zone,
                                    ],
                                    [
                                      'Dealer Code',
                                      false,
                                      lp.lead!.dealerCode,
                                    ],
                                    [
                                      'Gross LTV',
                                      false,
                                      lp.lead!.grossLtv,
                                    ],
                                    [
                                      'NET Ltv',
                                      false,
                                      lp.lead!.netLtv,
                                    ],
                                    [
                                      'SE Name',
                                      false,
                                      lp.lead!.seName,
                                    ],
                                    [
                                      'SE Code',
                                      false,
                                      lp.lead!.seCode,
                                    ],
                                    [
                                      'Customer Category',
                                      false,
                                      lp.lead!.customerCategory,
                                    ],
                                    [
                                      'Risk Band',
                                      false,
                                      lp.lead!.riskBand,
                                    ],
                                    [
                                      'Contactability Index',
                                      false,
                                      lp.lead!.contactabilityIndex,
                                    ],
                                    [
                                      'Digital Affinity',
                                      false,
                                      lp.lead!.digitalAffinity,
                                    ],
                                    [
                                      'Loan Status',
                                      false,
                                      lp.lead!.loanStatus,
                                    ],
                                    [
                                      'Strategy',
                                      false,
                                      lp.lead!.strategy,
                                    ],
                                    [
                                      'Loan Age',
                                      false,
                                      lp.lead!.loan_age,
                                    ],
                                    [
                                      'Color Code',
                                      false,
                                      lp.lead!.color_code,
                                    ],
                                    [
                                      'Mob',
                                      false,
                                      lp.lead!.mob,
                                    ],
                                    [
                                      'Mob Type',
                                      false,
                                      lp.lead!.mob_type,
                                    ],
                                    [
                                      'Recovery No.',
                                      false,
                                      lp.lead!.recovery_no,
                                    ],
                                    [
                                      'Priority Pool',
                                      false,
                                      lp.lead!.priority_pool,
                                    ],
                                    [
                                      'E-Receipting Ids',
                                      false,
                                      lp.lead!.e_receipting_ids,
                                    ],
                                  ],
                                ),
                                // LeadDetailsScreen(
                                //   leadName: lead.customername ?? '',
                                //   loanId: lead.loanAgreementNo ?? '',
                                //   leadAltContact: lead.customerAddPhone2 == null
                                //       ? 'No Alternate Number'
                                //       : lead.customerAddPhone2!,
                                //   leadContact: lead.mobNumber ?? '',
                                //   leadDate: lead.date ?? "",
                                //   leadEmail: '',
                                //   avg_amount: '',
                                //   assignUser: '',
                                //   assigndUsers: '',
                                //   agents: lead.agents ?? [],
                                // ),
                                LeadNotesScreen(
                                  notes: lead.newComments ?? [],
                                  addCommentWidget: AddLeadNoteScreen(
                                      leadId: lead.id.toString(),
                                      leadName: lead.customername ?? ""),
                                ),
                                ScheduledCall(leadId: lead.id.toString()),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: themeColor,
              ),
              body: const Center(
                child: Text('Couldn\'t load data'),
              ));
        }
      }
    });
  }
}
