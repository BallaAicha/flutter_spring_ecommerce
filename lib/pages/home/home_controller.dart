import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/apis/user_api.dart';
import '../../global.dart';
import 'bloc/home_page_blocs.dart';
import 'bloc/home_page_events.dart'; // Importer UserAPI

class HomeController {
  // On le déclare comme étant un singleton car on ne veut pas à chaque fois qu'on navigue vers cette page créer une nouvelle instance et cela fait beaucoup d'appel à l'API ce qui consomme beaucoup de ressources
  late BuildContext context;

  static final HomeController _singleton = HomeController
      ._external(); // Pour créer un constructeur privé pour le singleton, external est juste un nom de constructeur

  HomeController._external();

  // Ceci est un constructeur de type factory
  // Il s'assure que vous avez la seule instance originale, c'est-à-dire une seule instance
  factory HomeController({required BuildContext context}) {
    // Ce factory nous permet d'être sûr qu'on a une seule instance de la classe
    _singleton.context = context;
    return _singleton;
  }

  // String getUserName() {
  //   String token = Global.storageService.getUserToken();
  //   Map<String, dynamic> payload = jsonDecode(
  //     ascii.decode(
  //       base64.decode(
  //         base64.normalize(token.split(".")[1]),
  //       ),
  //     ),
  //   );
  //   return payload['preferred_username'] ?? '';
  // }
  String getUserName() {
    String token = Global.storageService.getUserToken();
    if (token.isNotEmpty) {
      List<String> parts = token.split(".");
      if (parts.length > 1) {
        Map<String, dynamic> payload = jsonDecode(
          ascii.decode(
            base64.decode(
              base64.normalize(parts[1]),
            ),
          ),
        );
        return payload['preferred_username'] ?? '';
      }
    }
    return '';
  }

  Future<void> init() async {
    if (Global.storageService.getIsLoggedIn()) {
      var result =
          await UserAPI.getProducts(); // Changer en UserAPI.getProducts()
      if (result != null) {
        // Vérifier si le résultat n'est pas null
        if (context.mounted) {
          context.read<HomePageBlocs>().add(
              HomePageProductItem(result)); // Changer en HomePageProductItem
          String userName = getUserName();
          print("User name: $userName");
          return;
        }
      } else {
        print("Échec de la récupération des produits");
        return;
      }
    } else {
      print("L'utilisateur s'est déjà déconnecté");
    }
    return;
  }
}
