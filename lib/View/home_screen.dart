import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_project/Controllers/movies_controller.dart';
import 'package:test_project/Models/upcoming_movies.dart';
import 'package:test_project/View/search_screen.dart';
import 'package:test_project/utils/app_colors.dart';

import '../utils/App-TextStyle.dart';
import 'movie_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MovieListScreen(),
    MovieListScreen(),
    MovieListScreen(),
    MovieListScreen(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title:  Text('Watch',style: AppTextStyle.mediumBlack16,),
        backgroundColor: AppColors.white,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            Get.find<MoviesController>().searchResult = RxList<MovieDetail>([]);
            Get.find<MoviesController>().update();
            Get.to(MovieSearchScreen());
          }, icon: Icon(Iconsax.search_normal_14,color: AppColors.black,))
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0), ),
        child: SizedBox(
          height: 70,
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            elevation: 0,
            landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Iconsax.menu),
                label: 'Dashboard',
                backgroundColor: AppColors.primary,
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.video_square),
                label: 'Watch',
                backgroundColor: AppColors.primary,
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.collections_solid ),
                label: 'Media Library',
                backgroundColor: AppColors.primary,
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.list_bullet),
                label: 'More',
                backgroundColor: AppColors.primary,
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: AppColors.white,
            unselectedItemColor: AppColors.darkGrey,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
