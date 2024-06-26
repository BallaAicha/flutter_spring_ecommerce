import 'package:e_commerce/pages/home/widgets/home_page_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/base_text_widget.dart' as res;
import '../search/search_controller.dart';
import 'bloc/home_page_blocs.dart';
import 'bloc/home_page_states.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //late UserItem userProfile;
  late MySearchController _searchController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _searchController = MySearchController(context: context);
    _searchController.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBarr("assets/avatar-1.png"),
      body: RefreshIndicator(
        onRefresh: () {
          return HomeController(context: context).init();
        },
        child: BlocBuilder<HomePageBlocs, HomePageStates>(
          builder: (context, state) {
            if (state.productItem.isEmpty) {
              HomeController(context: context).init();
            }
            return Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 25.w),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: homePageText(
                      "Hello, ${HomeController(context: context).getUserName()}",
                      color: AppColors.primaryThirdElementText,
                    ),
                  ),
                  // SliverToBoxAdapter(
                  //   child: homePageText(
                  //       userProfile.name ?? "", top: 5),
                  // ),
                  SliverPadding(
                    padding: EdgeInsets.only(top: 20.h),
                  ),
                  SliverToBoxAdapter(
                    child: res.searchView(
                        context, _searchController, "Products you might like",
                        home: false),
                  ),
                  SliverToBoxAdapter(
                    child: slidersView(context, state),
                  ),
                  SliverToBoxAdapter(
                    child: menuView(),
                  ),
                  SliverPadding(
                    padding:
                        EdgeInsets.symmetric(vertical: 18.h, horizontal: 0.w),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,//signifie que nous voulons 2 éléments par ligne
                              mainAxisSpacing: 15,//espace entre les éléments
                              crossAxisSpacing: 15,//espace entre les lignes
                              childAspectRatio: 1.6),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed("/product_detail", arguments: {
                                "id": state.productItem[index].id,
                              });
                            },
                            child: productGrid(state.productItem[index]),
                          );
                        },
                        childCount: state.productItem.length,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
