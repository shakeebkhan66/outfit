import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/components/auth/social_auth_page.dart';
import 'package:outfit/src/components/home/home_page.dart';
import 'package:outfit/src/data/model/password_model.dart';
import 'package:outfit/src/data/model/user_model.dart';
import 'package:outfit/src/data/model/user_return_data.dart';
import 'package:outfit/src/data/model/user_return_data.dart' as ruser;
import 'package:outfit/src/data/repository/auth_local_data_repo.dart';
import 'package:outfit/src/data/repository/auth_repo.dart';
import 'package:outfit/src/services/analytics.dart';
import 'package:outfit/src/utils/app_utils.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

enum AuthProvider {
  gmail('google'),
  fb('facebook'),
  email('email'),
  apple('apple');

  final String value;
  const AuthProvider(this.value);
}

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool _loading = false;
  bool get loading => _loading;

  bool _passwordLoading = false;
  bool get passwordLoading => _passwordLoading;

  bool _accountDelLoading = false;
  bool get accountDelLoading => _accountDelLoading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  setPasswordUpdateLoading(bool value) {
    _passwordLoading = value;
    notifyListeners();
  }

  setAccountDeleteLoading(bool value) {
    _accountDelLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(UserModel data, BuildContext context) async {
    setLoading(true);
    _myRepo.loginApi(data.toJson()).then((userData) {
      UserReturnData userReturnData = UserReturnData.fromJson(userData);
      setLoading(false);
      setDataToLocalStorage(
        UserModel(
          userid: userReturnData.data![0].uid!.toString(),
          email: userReturnData.data![0].email!,
          first_name: userReturnData.data![0].firstName!,
          last_name: userReturnData.data![0].lastName!,
          type: userReturnData.data![0].type,
          authProvider: data.authProvider,
        ),
      );
      AppAnalytics.onLogin(data.authProvider!.value);
      AppUtils.flushBarSucessMessage('Login Successfully', context).then((value) {
        AppNavigation.toReplace(context, const HomePage());
      });
      if (kDebugMode) {
        print(userData.toString());
      }
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
      setLoading(false);
      AppUtils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> socialLoginApi(UserModel data, BuildContext context) async {
    setLoading(true);
    late UserCredential? value;
    if (data.authProvider == AuthProvider.gmail) {
      value = await signInWithGoogle(context);
    } else if (data.authProvider == AuthProvider.fb) {
      value = await signInWithFacebook(context);
    } else if (data.authProvider == AuthProvider.apple) {
      value = await signInWithApple();
    }
    if (value != null) {
      print("rvalue2:${value.credential!.providerId!}:${value.user!.uid}");
      _myRepo
          .socialLogin(UserModel(
        userid: data.authProvider == AuthProvider.gmail?
        value.additionalUserInfo!.profile!["sub"]:
        value.user!.uid,
        name: value.user!.displayName,
        type: data.authProvider!.value,
        email: value.user!.email,
      ).toJson())
          .then((rvalue) {
            print(value);
//            print("rvalue:$rvalue:${rvalue['data']["userid"]}:${value.additionalUserInfo!.profile!["sub"]}");
            setDataToLocalStorage(UserModel(
          userid: rvalue['data']["userid"],
          name: value!.user!.displayName,
          type: data.authProvider!.value,
          email: value.user!.email,
        ));
        setLoading(false);
        AppAnalytics.onLogin(data.authProvider!.value);
        AppUtils.flushBarSucessMessage('Login Successfully', context).then((value) {
          AppNavigation.navigateRemoveUntil(context, const HomePage());
        });
        if (kDebugMode) {
          print("value.toString():${value.toString()}");
        }
      }).onError((error, stackTrace) {
        setLoading(false);
        AppUtils.flushBarErrorMessage(error.toString(), context);
        if (kDebugMode) {
          print(error.toString());
        }
      });
    } else {
      setLoading(false);
      AppUtils.flushBarErrorMessage("Error occured", context);
    }
  }

  Future<void> signUpApi(UserModel data, BuildContext context) async {
    setSignUpLoading(true);

    _myRepo.signUpApi(data.toJson()).then((value) {
      setSignUpLoading(false);
      ruser.Data userReturnData = ruser.Data.fromJson(value['data']);
      setDataToLocalStorage(
        UserModel(
          userid: userReturnData.uid!.toString(),
          email: userReturnData.email!,
          first_name: userReturnData.firstName!,
          last_name: userReturnData.lastName!,
          authProvider: data.authProvider,
        ),
      );
      AppUtils.flushBarSucessMessage('SignUp Successfully', context).then((value) {
        AppNavigation.toReplace(context, const HomePage());
      });
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      print(stackTrace);
      setSignUpLoading(false);
      AppUtils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> passwordUpdateApi(PasswordModel data, BuildContext context) async {
    setPasswordUpdateLoading(true);
    _myRepo.updatePasswordApi(data.toJson()).then((value) {
      setPasswordUpdateLoading(false);
      AppUtils.flushBarSucessMessage('Password update Successfully', context);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setPasswordUpdateLoading(false);
      AppUtils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> accountDelApi(String data, BuildContext context) async {
    setAccountDeleteLoading(true);
    _myRepo.delAccountdApi(data).then((value) {
      setAccountDeleteLoading(false);
      AppUtils.flushBarSucessMessage('Account deleted Successfully', context);
      Future.delayed(const Duration(seconds: 2), () {
        AppNavigation.navigateRemoveUntil(context, const SocialAuthPage());
      });
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setAccountDeleteLoading(false);
      AppUtils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<UserCredential> signInWithGoogle(context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: ['profile', 'email']).signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      print(credential.providerId);
      print(googleUser.id);
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential;
    }catch (e) {
      AppUtils.flushBarErrorMessage(e.toString(), context);
      FirebaseCrashlytics.instance.log(e.toString());
      throw Exception(e.toString());
    }
    throw Exception("Error occurs with google sign in");
  }

  Future<UserCredential> signInWithApple() async {
    final appleIdCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      // webAuthenticationOptions: WebAuthenticationOptions(
      //   clientId: clientID,
      //   redirectUri: Uri.parse(
      //       redirectURL),
      //   ),
    );
    final oAuthProvider = OAuthProvider('apple.com');
    final credential = oAuthProvider.credential(
      idToken: appleIdCredential.identityToken!,
      accessToken: appleIdCredential.authorizationCode,
    );
    final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
    if (userCredential.additionalUserInfo!.isNewUser) {
      final user = userCredential.user!;
      final String givenName = appleIdCredential.givenName ?? "";

      final String familyName = appleIdCredential.familyName ?? "";
      await user.updateDisplayName("$givenName $familyName").onError((error, stackTrace) => print);
      await user.reload();
    }
    return userCredential;
  }

  Future<UserCredential?> signInWithFacebook(BuildContext context) async {
    try{
    final LoginResult result = await FacebookAuth.instance.login(
   //   loginBehavior: LoginBehavior.dialogOnly,
      permissions: ['email', 'public_profile'],
    );
// Check result status
    switch (result.status) {
      case LoginStatus.success:
        print("result.accessToken!.userId:${result.accessToken!.toJson()}");

        // Send access token to server for validation and auth
        OAuthCredential authCredential = FacebookAuthProvider.credential(result.accessToken!.token);
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(authCredential);
        print(userCredential.additionalUserInfo!.profile);
        return userCredential;
      case LoginStatus.cancelled:
        return null;
      case LoginStatus.failed:
        AppUtils.flushBarErrorMessage(result.message.toString(), context);
        return null;
      default:
        AppUtils.flushBarErrorMessage(result.message.toString(), context);
        return null;
    }}catch(e){
      AppUtils.flushBarErrorMessage(e.toString(), context);
      return null;
    }
  }

  setDataToLocalStorage(UserModel data) {
    AuthLocalDataSource.setEmail(data.email!);
    AuthLocalDataSource.setUserid(data.userid!);

    if (data.authProvider == AuthProvider.email) {
      AuthLocalDataSource.setUserName(data.first_name! + data.last_name!);
    } else {
      AuthLocalDataSource.setUserName(data.name!);
    }
  }
}
