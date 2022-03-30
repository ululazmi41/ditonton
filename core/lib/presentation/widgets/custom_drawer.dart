import '../../utils/routes.dart';
import '../pages/home_movie_page.dart';
import '../pages/home_tv_page.dart';
import '../pages/watchlist_movies_page.dart';
import '../pages/watchlist_tvs_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final Widget content;

  CustomDrawer({
    required this.content,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Widget currentPage = widget.content;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  Widget _buildDrawer() {
    return Container(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://raw.githubusercontent.com/dicodingacademy/assets/main/flutter_expert_academy/dicoding-icon.png'),
            ),
            accountName: Text("Ulul Azmi"),
            accountEmail: Text("ululazmi4bs@gmail.com"),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text("Movies"),
            onTap: () => setState(() {
              toggle();
              currentPage = HomeMoviePage();
            }),
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text("TV Series"),
            onTap: () => setState(() {
              toggle();
              currentPage = HomeTvPage();
            }),
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text("Watchlist Movies"),
            onTap: () => setState(() {
              toggle();
              currentPage = WatchlistMoviesPage();
            }),
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text("Watchlist Tvs"),
            onTap: () => setState(() {
              toggle();
              currentPage = WatchlistTvsPage();
            }),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, ABOUT_ROUTE);
              _animationController.reverse();
            },
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
    );
  }

  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          double slide = 255.0 * _animationController.value;
          double scale = 1 - (_animationController.value * 0.3);

          return Stack(
            children: [
              _buildDrawer(),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: currentPage,
              ),
            ],
          );
        },
      ),
    );
  }
}
