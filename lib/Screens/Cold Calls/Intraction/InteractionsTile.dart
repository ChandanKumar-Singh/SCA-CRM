import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class InteractionsTile extends StatelessWidget {
  const InteractionsTile(
      {Key? key,
      required this.name,
      required this.applicationId,
      required this.date,
      required this.time,
      required this.followupStatus,
      required this.phone,
      required this.planToDo,
      required this.context,
      this.color,
      required this.statusUpdateMethod})
      : super(key: key);
  final String name;
  final String applicationId;
  final String date;
  final String time;
  final String followupStatus;
  final String phone;
  final String planToDo;
  final BuildContext context;
  final Color? color;
  final Future<void> Function(String data) statusUpdateMethod;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        shadowColor: Colors.black,
        elevation: 3,
        // color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name : ' + name,
                    style: TextStyle(
                        color: color ?? Colors.black,
                        fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text("Application ID : "),
                      Text(
                        applicationId,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Schedule : ' + date + ' ' + time,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text("Status : "),
                      Text(
                        followupStatus,
                        style: TextStyle(
                            color: followupStatus == 'Done'
                                ? Colors.green
                                : followupStatus == 'Not Done'
                                    ? Colors.amber
                                    : Colors.red),
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),
              Expanded(
                  child: InkWell(
                onTap: () {
                  planToDo == 'Call Back'
                      ? _makePhoneCall('tel:$phone')
                      : _textMe(phone);
                  // Share.share(
                  //   'check out this Lead Name ${intProvider.InteractionData[index].leads[0].name.toString()}\nLead id : ${intProvider.InteractionData[index].leadId.toString()} Date : ${intProvider.InteractionData[index].createdAt.toString()}',
                  // );
                },
                child: planToDo == 'Call Back'
                    ? const Icon(
                        Icons.call,
                        color: Colors.green,
                      )
                    : const Icon(
                        Icons.message_outlined,
                        color: Colors.black,
                      ),
              )),
              SizedBox(
                width: 20.w,
              ),
              InkWell(
                onTap: () {
                  // Share.share(
                  //   'check out this Lead Name ${intProvider.InteractionData[index].leads[0].name.toString()}\nLead id : ${intProvider.InteractionData[index].leadId.toString()} Date : ${intProvider.InteractionData[index].createdAt.toString()}',
                  // );
                  showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return CupertinoActionSheet(
                          title: const Text(
                            'Update Status',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                await statusUpdateMethod('Done')
                                    .then((value) =>
                                        print('Status Changed ---> '))
                                    .then(
                                        (value) => Navigator.of(context).pop());
                              },
                              child: const Text(
                                'Done',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                await statusUpdateMethod('Not Done')
                                    .then((value) =>
                                        print('Status Changed ---> '))
                                    .then(
                                        (value) => Navigator.of(context).pop());
                              },
                              child: const Text(
                                'Not Done',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                await statusUpdateMethod('Cancelled')
                                    .then((value) =>
                                        print('Status Changed ---> '))
                                    .then(
                                        (value) => Navigator.of(context).pop());
                              },
                              child: const Text(
                                'Cancelled',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ),
                          ],
                          cancelButton: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Go Back'),
                          ),
                        );
                      });
                },
                child: const Icon(Icons.more_vert),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e);
    }
  }

  _textMe(var number) async {
    print(number);
    // Android
    var uri = "sms:+$number?body=hello%20there";
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      var uri = 'sms:+$number?body=hello%20there';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }
}
