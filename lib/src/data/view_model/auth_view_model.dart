

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/components/home/home_page.dart';
import 'package:outfit/src/data/repository/auth_repo.dart';
import 'package:outfit/src/utils/app_utils.dart';

class AuthViewModel with ChangeNotifier {

  final _myRepo = AuthRepository();

  bool _loading = false ;
  bool get loading => _loading ;

  bool _signUpLoading = false ;
  bool get signUpLoading => _signUpLoading ;


  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value){
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data , BuildContext context) async {

    setLoading(true);

    _myRepo.loginApi(data).then((value){
      setLoading(false);
      AppUtils.flushBarSucessMessage('Login Successfully', context).then((value) {
      AppNavigation.toReplace(context, const HomePage());
      });
      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setLoading(false);
      AppUtils.flushBarErrorMessage(error.toString(), context);
      if(kDebugMode){
        print(error.toString());
      }
    });
  }


  Future<void> signUpApi(dynamic data , BuildContext context) async {

    setSignUpLoading(true);

    _myRepo.signUpApi(data).then((value){
      setSignUpLoading(false);
      AppUtils.flushBarSucessMessage('SignUp Successfully', context).then((value) {
        AppNavigation.toReplace(context, const HomePage());
      });
      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setSignUpLoading(false);
      AppUtils.flushBarErrorMessage(error.toString(), context);
      if(kDebugMode){
        print(error.toString());
      }
    });
  }

}