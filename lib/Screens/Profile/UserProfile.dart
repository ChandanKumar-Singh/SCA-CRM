import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:badges/badges.dart';
import 'package:crm_application/Provider/AuthProvider.dart';
import 'package:crm_application/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../ApiManager/Apis.dart';
import '../../Utils/Constant.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int? userId, phone;
  var authToken,
      fName = '',
      lName = '',
      dob = '',
      email = ''; //address='Please fill the address';
  late SharedPreferences prefs;
  bool _isLoading = false;
  File? _image;
  final picker = ImagePicker();
  final _fNameController = TextEditingController();
  final _lNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _altPhoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _dobController = TextEditingController();
  final _passwordController = TextEditingController();
  var images = '';
  String? userProfile, address;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CheckState();
    Timer(const Duration(seconds: 1), () {
      setState(() {});
    });
  }

  void CheckState() async {
    prefs = await SharedPreferences.getInstance();
    setState(
      () {
        userId = prefs.getInt('userId')!;
        fName = prefs.getString('fname')!;
        lName = prefs.getString('lname')!;
        dob = prefs.getString('dob')!;
        if(dob!=null){
          _dobController.text=dob;
        }
        email = prefs.getString('email')!;
        _phoneController.text = prefs.getString('phone') != null
            ? prefs.getString('phone')!.toString()
            : '';
        _addressController.text = prefs.getString('address') != null
            ? prefs.getString('address')!
            : '';

        address = prefs.getString('address');
        authToken = prefs.getString('token');
        userProfile = prefs.getString('image');
      },
    );

    debugPrint('CheckUserId : $userId');
    debugPrint('CheckUserName : $fName');
    debugPrint('CheckUserLName : $lName');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        titleSpacing: 0,
        title: const Text(
          "User Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) => Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _showPicker(context, userId);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1),
                        ),
                        child: Badge(
                          badgeColor: themeColor,
                          animationDuration: const Duration(seconds: 10),
                          position: BadgePosition.bottomEnd(),
                          badgeContent: const Icon(
                            Icons.camera_alt_outlined,
                            size: 15,
                            color: Colors.white,
                          ),
                          child: !_isLoading
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child:
                                      userProfile == null || userProfile == ''
                                          ? SizedBox(
                                              height: 85.h,
                                              width: 80.w,
                                              child: Image.asset(
                                                'assets/images/person.jpeg',
                                                scale: 3,
                                              ),
                                            )
                                          : SizedBox(
                                              height: 85.h,
                                              width: 80.w,
                                              child: Image.network(
                                                userProfile!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                      height: 85.h,
                                      width: 80.w,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      )),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "User ID : ${userId.toString()}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            '$fName $lName', //"Testing User",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "DOB : ${dob ?? 'N/A'}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text(
                          'First Name',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _fNameController,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[150],
                        filled: true,
                        labelText: fName,
                        prefixIcon: const Icon(Icons.edit),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        Text(
                          'Last Name',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _lNameController,
                      decoration: InputDecoration(
                          fillColor: Colors.grey[150],
                          filled: true,
                          labelText: lName,
                          prefixIcon: const Icon(Icons.edit),
                          border: const OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        Text(
                          'Email Id',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                          fillColor: Colors.grey[150],
                          filled: true,
                          hintText: email,
                          prefixIcon: const Icon(Icons.email),
                          border: const OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        Text(
                          'Phone',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      decoration: InputDecoration(
                          fillColor: Colors.grey[150],
                          filled: true,
                          labelText: "phone",
                          prefixIcon: const Icon(Icons.edit),
                          border: const OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        Text(
                          'Alternate Contact',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _altPhoneController,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[150],
                        filled: true,
                        labelText: 'Please fill alternate contact',
                        prefixIcon: const Icon(Icons.edit),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        Text(
                          'Address',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[150],
                        filled: true,
                        labelText: address ?? 'Please fill the address',
                        //'Please fill the address',
                        prefixIcon: const Icon(Icons.edit),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        Text(
                          'Date of birth',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _dobController,
                      readOnly: true,
                      onTap: () async {
                        var dt = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now()
                                .subtract(Duration(days: 365 * 10)),
                            firstDate: DateTime(1997),
                            lastDate:
                                DateTime.now().subtract(Duration(days: 365)));
                        if (dt != null) {
                          setState(() {
                            _dobController.text =
                                DateFormat('dd MMM yyyy').format(dt);
                          });
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.grey[150],
                        filled: true,
                        labelText: 'Date of birth',
                        //'Please fill the address',
                        prefixIcon: const Icon(Icons.edit),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        Text(
                          'Password',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[150],
                        filled: true,
                        labelText: 'Change password',
                        //'Please fill the address',
                        prefixIcon: const Icon(Icons.edit),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    !authProvider.isLoading
                        ? InkWell(
                            onTap: () {
                              setState(
                                () {
                                  authProvider.updateProfile(
                                    userId.toString(),
                                    _fNameController.text.isEmpty
                                        ? fName
                                        : _fNameController.text,
                                    _lNameController.text.isEmpty
                                        ? lName
                                        : _lNameController.text,
                                    _phoneController.text.isEmpty
                                        ? phone.toString()
                                        : _phoneController.text,
                                    _altPhoneController.text,
                                    _addressController.text,
                                    _dobController.text,
                                    _passwordController.text,
                                    authToken.toString(),
                                    context,
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text(
                                  "UPDATE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> uploadImage(int userId) async {
    var url = ApiManager.BASE_URL + ApiManager.updateProfilePicture;
    final headers = {
      'Authorization-token': ApiManager.Authorization_token,
      'Authorization': 'Bearer $authToken',
      'Accept': 'application/json',
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    try {
      setState(
        () {
          _isLoading = true;
        },
      );
      request.files
          .add(await http.MultipartFile.fromPath('user_profile', _image!.path));
      request.fields['user_id'] = userId.toString();
      request.headers.addAll(headers);
      var res = await request.send();
      var responseData = await res.stream.toBytes();
      var result = String.fromCharCodes(responseData);
      log('ImageResponse : ${result.toString()}');
      var imageResponse = json.decode(result.toString());
      var success = imageResponse['success'];
      var data = imageResponse['data'];
      if (success == 200) {
        setState(
          () {
            var images = data['user_profile'];
            prefs.setString('image', images);
          },
        );
        print('7777777777777777777777777');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('success'),
          ),
        );
        print('7777777777777777777777777');
        await Provider.of<AuthProvider>(context, listen: false).login(
            prefs.getString('email')!,
            prefs.getString('password')!,
            prefs.getString(Const.FCM_TOKEN)!,
            context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const UserProfile(),
          ),
        );
      } else {
        setState(
          () {
            _isLoading = false;
          },
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('error'),
          ),
        );
      }
    } catch (e) {
      setState(
        () {
          _isLoading = false;
        },
      );
      print('upload image $e');
    }
  }

  void _pickImage(int userId) async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          uploadImage(userId);
          debugPrint('Image path : ${_image!.path.toString()}');
        } else {
          debugPrint("No image selected");
        }
      });
    } catch (e) {
      debugPrint("Image picker error $e");
    }
  }

  Future getImageWithCamera(int userId) async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 90);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      uploadImage(userId);
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No image selected'),
          ),
        );
      });
    }
  }

  void _showPicker(context, userId) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Pick From Gallery'),
                      onTap: () {
                        _pickImage(userId);
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      getImageWithCamera(userId);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
