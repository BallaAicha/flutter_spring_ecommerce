import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../common/apis/user_api.dart';
import '../../common/entities/LoginRequestEntity.dart';
import '../../common/utils/http_util.dart';
import '../../common/values/constant.dart';
import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'bloc/sign_in_blocs.dart';

class SignInController {
  final BuildContext context;

  const SignInController({required this.context});

  Future<void> handleSignIn(String type) async {
    if (type == "email") {
      final state = context.read<SignInBloc>().state;
      String username = state.username;
      String password = state.password;

      if (username.isEmpty) {
        toastInfo(msg: "You need to fill username");
        return;
      }
      if (password.isEmpty) {
        toastInfo(msg: "You need to fill password");
        return;
      }

      EasyLoading.show(
          indicator: CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);

      try {
        String? accessToken = await HttpUtil().authenticate(username, password);

        if (accessToken != null) {
          Global.storageService
              .setString(AppConstants.STORAGE_USER_PROFILE_KEY, accessToken);
          Global.storageService
              .setString(AppConstants.STORAGE_USER_TOKEN_KEY, accessToken);
          print('Access Token: $accessToken');
          // Call createUserWithKeycloakInfo after successful authentication
          await createUserWithKeycloakInfo();
          EasyLoading.dismiss();
          if (context.mounted) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/application", (route) => false);
          }
        } else {
          EasyLoading.dismiss();
        }
      } catch (e) {
        EasyLoading.dismiss();
        print('Failed to authenticate. Error: $e');
      }
    }
  }
}

Future<void> createUserWithKeycloakInfo() async {
  String? accessToken = Global.storageService.getUserToken();

  if (accessToken != null) {
    // Decode the token to get the user information
    Map<String, dynamic> tokenInfo = JwtDecoder.decode(accessToken);

    // Create a new LoginRequestEntity with the user information from the token
    Address address =
        Address(street: 'UnKnow', houseNumber: 'UnKnow', zipCode: 'UnKnow');
    LoginRequestEntity params = LoginRequestEntity(
      id: tokenInfo["sub"],
      firstname: tokenInfo["given_name"],
      lastname: tokenInfo["family_name"],
      email: tokenInfo["email"],
      address: address,
    );

    // Send the request to the backend to create the user
    var response = await UserAPI.login(params: params);
    if (response != null) {
      print('User created successfully. Response: $response');
    } else {
      print('Failed to create user. Response was null.');
    }
  } else {
    print('No access token found');
  }
}
