import 'package:crm_application/Models/NewModels/UserModel.dart';
import 'package:flutter/material.dart';

enum UserType{admin,hr,teamleader,jrteamleader,agent,staff}

class UserProvider extends ChangeNotifier{
late String role;
late UserModel user;

void setUser(UserModel u){
  user=u;
  print('user set done user provider');
  notifyListeners();
}

}