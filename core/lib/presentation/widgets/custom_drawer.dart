import '../../utils/routes.dart';
import 'package:flutter/material.dart';

import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';

import 'package:tv/presentation/pages/home_tv_page.dart';
import 'package:tv/presentation/pages/watchlist_tvs_page.dart';

class CustomDrawer extends StatefulWidget {
  final Widget content;

  const CustomDrawer({Key? key, required this.content}) : super(key: key);

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
      duration: const Duration(milliseconds: 250),
    );
  }

  Widget _buildDrawer() {
    return Column(
      children: [
        const UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://raw.githubusercontent.com/dicodingacademy/assets/main/flutter_expert_academy/dicoding-icon.png'),
          ),
          accountName: Text("Ulul Azmi"),
          accountEmail: Text("ululazmi4bs@gmail.com"),
        ),
        ListTile(
          leading: const Icon(Icons.movie),
          title: const Text("Movies"),
          onTap: () => setState(() {
            toggle();
            currentPage = const HomeMoviePage();
          }),
        ),
        ListTile(
          leading: const Icon(Icons.tv),
          title: const Text("TV Series"),
          onTap: () => setState(() {
            toggle();
            currentPage = const HomeTvPage();
          }),
        ),
        ListTile(
          leading: const Icon(Icons.save_alt),
          title: const Text("Watchlist Movies"),
          onTap: () => setState(() {
            toggle();
            currentPage = const WatchlistMoviesPage();
          }),
        ),
        ListTile(
          leading: const Icon(Icons.save_alt),
          title: const Text("Watchlist Tvs"),
          onTap: () => setState(() {
            toggle();
            currentPage = const WatchlistTvsPage();
          }),
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, aboutRoute);
            _animationController.reverse();
          },
          leading: const Icon(Icons.info_outline),
          title: const Text('About'),
        ),
      ],
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
