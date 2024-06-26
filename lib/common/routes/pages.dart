import 'package:e_commerce/pages/cart/CartPage.dart';
import 'package:e_commerce/pages/cart/bloc/carts_bloc.dart';
import 'package:e_commerce/pages/favorite/bloc/FavoriteBloc.dart';
import 'package:e_commerce/pages/orders/orders_list.dart';
import 'package:e_commerce/pages/search/bloc/search_blocs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../global.dart';
import '../../pages/application/application_page.dart';
import '../../pages/application/bloc/app_blocs.dart';
import '../../pages/cart/cart_controller.dart';
import '../../pages/favorite/favorite_controller.dart';
import '../../pages/favorite/favorite_page.dart';
import '../../pages/home/bloc/home_page_blocs.dart';
import '../../pages/home/home_page.dart';
import '../../pages/orders/bloc/OrderBloc.dart';
import '../../pages/orders/order_controller.dart';
import '../../pages/product_detail/bloc/product_detail_blocs.dart';
import '../../pages/product_detail/course_detail.dart';
import '../../pages/profile/bloc/profile_blocs.dart';
import '../../pages/profile/profile.dart';
import '../../pages/profile/settings/bloc/settings_blocs.dart';
import '../../pages/profile/settings/settings_page.dart';
import '../../pages/search/search.dart';
import '../../pages/sign_in/bloc/sign_in_blocs.dart';
import '../../pages/sign_in/sign_in.dart';
import '../../pages/welcome/bloc/welcome_blocs.dart';
import '../../pages/welcome/welcome.dart';
import 'names.dart';

class AppPages {
  static List<PageEntity> routes() {
    String? accessToken = Global.storageService.getUserToken();
    String customerId = '';
    if (accessToken != null && accessToken.isNotEmpty) {
      try {
        Map<String, dynamic> tokenInfo = JwtDecoder.decode(accessToken);
        customerId = tokenInfo["sub"];
      } catch (e) {
        print('Invalid token: $e');
      }
    } else {
      print('No access token found');
    }
    return [
      PageEntity(
          route: AppRoutes.INITIAL,
          page: const Welcome(),
          bloc: BlocProvider(create: (_) => WelcomeBloc(),)
      ),
      PageEntity(
          route: AppRoutes.SING_IN,
          page: const SignIn(),
          bloc: BlocProvider(create: (_) => SignInBloc(),)
      ),

      PageEntity(
          route: AppRoutes.APPLICATION,
          page: const ApplicationPage(),
          bloc: BlocProvider(create: (_) => AppBlocs(
            customerId

          ),)
      ),
      PageEntity(
          route: AppRoutes.HOME_PAGE,
          page: const HomePage(),
          bloc: BlocProvider(create: (_) => HomePageBlocs(),)
      ),
      PageEntity(
          route: AppRoutes.SETTINGS,
          page: const SettingsPage(),
          bloc: BlocProvider(create: (_) => SettingsBlocs(),)
      ),
      PageEntity(
          route: AppRoutes.PRODUCT_DETAIL,
          page: const ProductDetail(),
          bloc: BlocProvider(create: (_) => ProductDetailBloc(),)
      ),
      PageEntity(
          route: AppRoutes.ORDERS,
          page: const OrdersList(),
          bloc: BlocProvider(create: (_) => OrderBloc(
            OrderControlller(),
          ),)
      ),

      PageEntity(
          route: AppRoutes.FAVORITES,
          page: const FavoritePage(),
          bloc: BlocProvider(create: (_) => FavoriteBloc(
            FavoriteController(),
          ),)
      ),
      PageEntity(
          route: AppRoutes.PROFILE,
          page: const ProfilePage(),
          bloc: BlocProvider(create: (_) => ProfileBlocs(),)
      ),
      PageEntity(
          route: AppRoutes.SEARCH,
          page: const Search(),
          bloc: BlocProvider(create: (_) => SearchBlocs(),)
      ),

      PageEntity(
          route: AppRoutes.CART,
          page: const CartPage(),
          bloc: BlocProvider(create: (_) => CartBloc(
            CartController(),
          ),)
      ),




    ];
  }

  //return all the bloc providers
  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()){
      blocProviders.add(bloc.bloc);
    }
    return blocProviders;
  }
  // a modal that covers entire screen as we click on navigator object
  static MaterialPageRoute GenerateRouteSettings(RouteSettings settings){
    if(settings.name!=null){

      //check for route name macthing when navigator gets triggered.
      var result = routes().where((element) => element.route==settings.name);
      if(result.isNotEmpty){
        bool deviceFirstOpen  = Global.storageService.getDeviceFirstOpen();
        if(result.first.route==AppRoutes.INITIAL&&deviceFirstOpen){
          bool isLoggedin = Global.storageService.getIsLoggedIn();
          if(isLoggedin){
            return MaterialPageRoute(builder: (_)=>const ApplicationPage(), settings: settings);
          }

          return MaterialPageRoute(builder: (_)=>const SignIn(), settings:settings);
        }
        return MaterialPageRoute(builder: (_)=>result.first.page, settings: settings);
      }

    }
    return MaterialPageRoute(builder: (_)=>const SignIn(), settings: settings);
  }

}


  class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({required this.route,  required this.page,  this.bloc});
  }