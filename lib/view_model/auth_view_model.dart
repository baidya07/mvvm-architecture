import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_architecture/repository/auth_repository.dart';

import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier{
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setSignUpLoading(bool value){
    _signUpLoading = value;
    notifyListeners();
  }

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async{
    setLoading(true);
    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      Utils.flushBarErrorMessage('Login Successfully', context);
      Navigator.pushNamed(context, RoutesName.home);
      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setLoading(false);
      if(kDebugMode){
        print(error.toString());
      }
    });
  }

  Future<void> signupApi(dynamic data, BuildContext context) async{
    setSignUpLoading(true);
    _myRepo.signupApi(data).then((value) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessage('Signup Successfully', context);
      Navigator.pushNamed(context, RoutesName.home);
      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setSignUpLoading(false);
      if(kDebugMode){
        print(error.toString());
      }
    });
  }
}