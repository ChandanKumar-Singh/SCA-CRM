import 'package:crm_application/Screens/Cold%20Calls/MyLeads/ClosedLeads/editClosedLeads.dart';
import 'package:flutter/material.dart';
import '../../../../Models/LeadsModel.dart';

class FieldControl extends StatefulWidget {
  const FieldControl(
      {Key? key, required this.lead, required this.fieldControle})
      : super(key: key);
  final Lead lead;
  final List<List> fieldControle;

  @override
  State<FieldControl> createState() => _FieldControlState();
}

class _FieldControlState extends State<FieldControl> {
  late Lead lead;
  List<List> fieldControle = [];
  bool _isLoading = false;
  ScrollController scrollController = ScrollController();

  List<TextEditingController> controllers = [];
  List<TextInputType> inputTypes = [];

  void initFields() {
    for (var element in fieldControle) {
      controllers.add(TextEditingController(text: '${element[2] ?? ''}'));
      if (element[1] != null) {
        inputTypes.add(element[2].runtimeType == 0.runtimeType
            ? TextInputType.number
            : TextInputType.name);
      }
    }
    _isLoading = false;
    setState(() {});
    print('Field count is ${controllers.length}  ${inputTypes.length}');
  }

  @override
  void initState() {
    super.initState();
    lead = widget.lead;
    fieldControle = widget.fieldControle;
    initFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      thickness: 15,
      showTrackOnHover: true,
      thumbVisibility: true,
      interactive: true,
      radius: const Radius.circular(10),
      child: ListView(
        controller: scrollController,
        children: [
          ...fieldControle.map((e) {
            int i = fieldControle.indexOf(e);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: CustomTextField(
                  readOnly: true,
                  onChange: (val) {
                    print(fieldControle[i][0].toString() +
                        '  ---  ' +
                        controllers[i].text);
                  },
                  titleStyle: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 20),
                  lableStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  title: '',
                  label: fieldControle[i][0],
                  required: false,
                  controller: controllers[i]),
            );
          }),
        ],
      ),
    );
  }
}
