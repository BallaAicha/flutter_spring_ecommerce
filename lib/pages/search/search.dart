import 'package:e_commerce/pages/search/search_controller.dart';
import 'package:e_commerce/pages/search/widgets/search_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/widgets/base_text_widget.dart' as res;
import 'bloc/search_blocs.dart';
import 'bloc/search_states.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late MySearchController _searchController;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _searchController = MySearchController(context: context);
    _searchController.init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBlocs, SearchStates>(builder: (context, state) {
      return Scaffold(
        appBar: res.buildAppBar("Search"),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
              sliver: SliverToBoxAdapter(
                child: res.searchView(
                    context, _searchController, "Products you might like",
                    home: false),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 0),
              sliver: SliverToBoxAdapter(
                child: SingleChildScrollView(
                  child: searchList(state),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
