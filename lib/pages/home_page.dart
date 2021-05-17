import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rush/utils/colors.dart';
import 'package:rush/widgets/app_inScreen_logo.dart';

class HomePage extends StatefulWidget {
  static final routeName = "HomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<HomeAction> homeActions = [
    HomeAction(
      action: () => print("1"),
      color: AppColors.Purple_Dark,
      icon: Icons.play_arrow,
      title: "Play Now",
      index: 1,
    ),
    HomeAction(
      action: () => print("2"),
      color: AppColors.Green_Dark,
      icon: Icons.play_arrow,
      title: "Prize  Pool",
      index: 2,
    ),
    HomeAction(
      action: () => print("3"),
      color: AppColors.Main_Orange,
      icon: Icons.play_arrow,
      title: "Leadership",
      index: 3,
    ),
    HomeAction(
      action: () => print("4"),
      color: AppColors.Blue_Dark,
      icon: Icons.play_arrow,
      title: "Profile",
      index: 4,
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      body: Column(
        children: [
          Image.asset(
            "assets/images/trivia_icon.png",
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          SizedBox(
            height: 20,
          ),
          actionsGrid(),
          Expanded(
            child: Image.asset("assets/images/homeBackground.png"),
          ),
        ],
      ),
    );
  }

  Widget actionsGrid() => Container(
        alignment: Alignment.center,
        child: Wrap(
          children: homeActions,
          runSpacing: 20,
          spacing: 20,
        ),
      );

  Widget homeAppBar() => PreferredSize(
        child: Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.menu,
                color: AppColors.Red_Dark,
                size: 50,
              ),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(30),
      );
}

class HomeAction extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final Function action;
  final int index;

  const HomeAction(
      {this.action, this.color, this.icon, this.title, this.index});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: MediaQuery.of(context).size.height * 0.19,
        height: MediaQuery.of(context).size.height * 0.19,
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headline3.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        )),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topLeft:
                  index == 2 || index == 3 ? Radius.circular(20) : Radius.zero,
              bottomRight:
                  index == 2 || index == 3 ? Radius.circular(20) : Radius.zero,
              topRight:
                  index == 1 || index == 4 ? Radius.circular(20) : Radius.zero,
              bottomLeft:
                  index == 1 || index == 4 ? Radius.circular(20) : Radius.zero,
            )),
      ),
    );
  }
}
