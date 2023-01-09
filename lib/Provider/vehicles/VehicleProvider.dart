import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:crm_application/Models/NewModels/vehicle.dart';
import 'package:flutter/widgets.dart';

import '../../ApiManager/Apis.dart';
import 'dart:io';
import 'package:crm_application/ApiManager/Apis.dart';
import 'package:crm_application/Models/NewModels/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VehicleProvider extends ChangeNotifier {
  String TAG = "VehicleProvider";
  String serpapi =
      '1a4f7a0018135197064ffc513ba510c41254d37afff45a3b8ce9cf549abd2800';
  String removeBgApi = 'Dv2AcZAEUJLmH2BFuoQ5U5Bn';
  var token;
  VehicleModel? vehicle;
  String? suggestedImg;
  int total = 0;
  ScrollController scrollController = ScrollController();
  List<VehicleModel> vehiclesList = [];

  bool isLoadingResult = false;
  bool isLoadingImage = false;
  int page = 1;

  Future<void> getVehicles(String query, bool loadMore) async {
    isLoadingResult = true;
    loadMore ? page++ : page = 1;

    notifyListeners();
    var url = ApiManager.BASE_URL + ApiManager.vehicles + '?page=$page';
    final headers = {
      'Authorization-token': ApiManager.Authorization_token,
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    Map<String, dynamic> body = {"keyword": query};
    try {
      final response =
          await http.post(Uri.parse(url), body: body, headers: headers);
      var responseData = json.decode(response.body);
      debugPrint("$TAG Parameters : $body");
      print("$TAG Response : $responseData");
      if (response.statusCode == 200) {
        isLoadingResult = false;
        if (responseData['success'] == 200) {
          var result = responseData['data']['data'];
          total = responseData['data']['total'];
          notifyListeners();
          print(result);
          if (page == 1) {
            vehiclesList.clear();
            notifyListeners();
          }
          try {
            if (result != null) {
              result.forEach((e) {
                vehiclesList.add(VehicleModel.fromJson(e));
              });
              notifyListeners();
            }
          } catch (e) {
            print(e);
          }
          isLoadingResult = false;
          notifyListeners();
        }
      } else {
        isLoadingResult = false;
        notifyListeners();
        throw const HttpException('Auth Failed');
      }
    } catch (error) {
      isLoadingResult = false;
      notifyListeners();

      rethrow;
    }
  }

  Future<void> loadSuggestionImage(String q) async {
    isLoadingImage = true;
    var query = q.toLowerCase().split(' ').join('');
    notifyListeners();
    var url =
        'https://serpapi.com/search.json?q=$query vehicle&tbm=isch&ijn=0&engine=google&api_key=$serpapi';
    // var url = 'https://serpapi.com/search.json?q=Apple&tbm=isch&ijn=0';
    final headers = {
      'Authorization-token': ApiManager.Authorization_token,
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    Map<String, dynamic> body = {"keyword": query};
    try {
      suggestedImg = null;
      final response = await http.get(Uri.parse(url));
      // var responseData = json.decode(response.body);
      debugPrint("$TAG Parameters : $url");
      print("$TAG Response : ${response}");
      // print("$TAG Response : ${response.body}");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data['images_results']);
        if (data['images_results'] != null) {
          suggestedImg =
              data['images_results'][Random().nextInt(10)]['original'];
          isLoadingImage = false;
          notifyListeners();
          print(suggestedImg);
        } else {
          // suggestedImg=''
        }

        // isLoadingImage = false;
        // if (responseData['success'] == 200) {
        //   var result = responseData['data'];
        //   vehiclesList.clear();
        //   notifyListeners();
        //   try {
        //     vehiclesList.add(VehicleModel.fromJson(result));
        //     notifyListeners();
        //   } catch (e) {
        //     print(e);
        //   }
        //   isLoadingImage = false;
        //   notifyListeners();
        // }
      } else {
        isLoadingImage = false;
        notifyListeners();
        throw const HttpException('Auth Failed');
      }
    } catch (error) {
      isLoadingImage = false;
      notifyListeners();

      rethrow;
    }
  }

  Future<void> cutSuggestionImage(String q) async {
    isLoadingImage = true;
    var query = q.toLowerCase().split(' ').join('');
    notifyListeners();
    var url =
        'https://serpapi.com/search.json?q=$query&tbm=isch&ijn=0&engine=google&api_key=1a4f7a0018135197064ffc513ba510c41254d37afff45a3b8ce9cf549abd2800';
    // var url = 'https://serpapi.com/search.json?q=Apple&tbm=isch&ijn=0';
    final headers = {
      'Authorization-token': ApiManager.Authorization_token,
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    Map<String, dynamic> body = {"keyword": query};
    try {
      suggestedImg = null;
      final response = await http.get(Uri.parse(url));
      // var responseData = json.decode(response.body);
      debugPrint("$TAG Parameters : $url");
      print("$TAG Response : ${response}");
      // print("$TAG Response : ${response.body}");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data['images_results']);
        if (data['images_results'] != null) {
          suggestedImg = data['images_results'][0]['original'];
          isLoadingImage = false;
          notifyListeners();
          print(suggestedImg);
        } else {
          // suggestedImg=''
        }

        // isLoadingImage = false;
        // if (responseData['success'] == 200) {
        //   var result = responseData['data'];
        //   vehiclesList.clear();
        //   notifyListeners();
        //   try {
        //     vehiclesList.add(VehicleModel.fromJson(result));
        //     notifyListeners();
        //   } catch (e) {
        //     print(e);
        //   }
        //   isLoadingImage = false;
        //   notifyListeners();
        // }
      } else {
        isLoadingImage = false;
        notifyListeners();
        throw const HttpException('Auth Failed');
      }
    } catch (error) {
      isLoadingImage = false;
      notifyListeners();

      rethrow;
    }
  }
}
