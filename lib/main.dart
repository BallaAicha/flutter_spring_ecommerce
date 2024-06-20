import 'package:e_commerce/pages/application/application_page.dart';
import 'package:e_commerce/pages/application/bloc/app_blocs.dart';
import 'package:e_commerce/pages/favorite/bloc/FavoriteBloc.dart';
import 'package:e_commerce/pages/favorite/favorite_controller.dart';
import 'package:e_commerce/pages/home/bloc/home_page_blocs.dart';
import 'package:e_commerce/pages/product_detail/bloc/product_detail_blocs.dart';
import 'package:e_commerce/pages/product_detail/course_detail.dart';
import 'package:e_commerce/pages/profile/bloc/profile_blocs.dart';
import 'package:e_commerce/pages/profile/settings/bloc/settings_blocs.dart';
import 'package:e_commerce/pages/profile/settings/settings_page.dart';
import 'package:e_commerce/pages/search/bloc/search_blocs.dart';
import 'package:e_commerce/pages/sign_in/bloc/sign_in_blocs.dart';
import 'package:e_commerce/pages/sign_in/sign_in.dart';
import 'package:e_commerce/pages/welcome/bloc/welcome_blocs.dart';
import 'package:e_commerce/pages/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'common/values/colors.dart';
import 'global.dart';

Future<void> main() async {
  await Global.init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WelcomeBloc()),
        BlocProvider(create: (context) => SignInBloc()),
        BlocProvider(create: (context) => AppBlocs()),
        BlocProvider(create: (context) => HomePageBlocs()),
        BlocProvider(create: (context) => SettingsBlocs()),
        //BlocProvider(create: (context) => ProfileBlocs())
        BlocProvider(create: (context) => ProductDetailBloc(),),
        BlocProvider(create: (context) => SearchBlocs()),
        BlocProvider(create: (context) => FavoriteBloc(FavoriteController())),

      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          routes: {
            '/sign_in': (context) => const SignIn(),
            '/application': (context) =>  const ApplicationPage(),
            '/settings': (context) => const SettingsPage(),
            '/product_detail': (context) => const ProductDetail(),
          },
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(
                    color: AppColors.primaryText,
                  ),
                  elevation: 0,
                  backgroundColor: Colors.white)),
          home: Welcome(),
        ),
      ),
    );
  }
}

