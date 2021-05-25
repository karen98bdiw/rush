import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rush/managment/game_managment.dart';
import 'package:rush/managment/user_managment.dart';
import 'package:rush/pages/game_start_onboard.dart';
import 'package:rush/pages/play_screen.dart';
import 'package:rush/utils/colors.dart';
import 'package:rush/utils/diologs.dart';

class HomePage extends StatefulWidget {
  static final routeName = "HomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<HomeAction> homeActions;
  UserManagment userManagment;
  GameManagment gameManagment;

  @override
  void initState() {
    homeActions = [
      HomeAction(
        action: onPlay,
        color: AppColors.Purple_Dark,
        assets: "assets/icons/play.png",
        title: "Play Now",
        index: 1,
      ),
      HomeAction(
        action: () => print("2"),
        color: AppColors.Green_Dark,
        assets: "assets/icons/prize.png",
        title: "Prize  Pool",
        index: 2,
      ),
      HomeAction(
        action: () => print("3"),
        color: AppColors.Main_Orange,
        assets: "assets/icons/leader.png",
        title: "Leadership",
        index: 3,
      ),
      HomeAction(
        action: () => print("4"),
        color: AppColors.Blue_Dark,
        assets: "assets/icons/person.png",
        title: "Profile",
        index: 4,
      ),
    ];
    userManagment = Provider.of<UserManagment>(context, listen: false);
    gameManagment = Provider.of<GameManagment>(context, listen: false);
    print("init ${userManagment.curentUser.email}");
    super.initState();
  }

  void onPlay() async {
    print("onPlay");
    var res = await gameManagment.pick(
      token: userManagment.token,
    );

    if (res.done && res.succses) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (v) => GameStartOnboard(),
        ),
      );
    } else {
      showError(
        errorText: "Sorry looks like you used all your free steps",
      );
    }
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (c) => PlayScreen(),
    // ));
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
  final String assets;
  final Color color;
  final String title;
  final Function action;
  final int index;

  const HomeAction(
      {this.action, this.color, this.assets, this.title, this.index});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: EdgeInsets.all(
          MediaQuery.of(context).orientation == Orientation.portrait ? 30 : 10,
        ),
        width: MediaQuery.of(context).size.height * 0.19,
        height: MediaQuery.of(context).size.height * 0.19,
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Image.asset(
                assets,
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            if (MediaQuery.of(context).orientation == Orientation.portrait)
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
