import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vc/theme/constant/const_colors.dart';
import 'package:vc/theme/constant/sized.dart';
import 'package:vc/view/home_view/home.dart';
import 'package:vc/view/messages/views/latest_message_screen.dart';
import '../order_histroy/order_history_screen.dart';
import '../user_profile/user_profile.dart';

class BottomNavBar extends StatefulWidget {
  final int initialIndex;
  const BottomNavBar({super.key, this.initialIndex = 0});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with TickerProviderStateMixin {
  late TabController tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);

    super.initState();
  }

  List<Widget> myPages = [
     HomeScreen(),
    const OrderHistoryScreen(),
    const LatestMessagesScreen(),
    UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: myPages,
      ),
      bottomNavigationBar: SizedBox(
        height: kBottomNavigationBarHeight,
        child: BottomAppBar(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15))
                    .r),
            child: TabBar(
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: ColorApp.primary,
                    width: screenUtil.setWidth(3),
                  ),
                  insets: const EdgeInsets.only(
                    right: 15,
                    left: 15,
                    bottom: kBottomNavigationBarHeight,
                  )),
              labelColor: ColorApp.primary,
              unselectedLabelColor: ColorApp.primary,
              controller: tabController,
              tabs: [
                Tab(
                    iconMargin: const EdgeInsets.only(bottom: 4),
                    icon: selectedIndex == 0
                        ? Image.asset(
                            "assets/icons/home.png",
                          )
                        : Image.asset(
                            "assets/icons/homec.png",
                          )),
                Tab(
                    iconMargin: const EdgeInsets.only(bottom: 4),
                    icon: selectedIndex == 1
                        ? Image.asset(
                            "assets/icons/b2c.png",
                          )
                        : Image.asset(
                            "assets/icons/b2.png",
                          )),
                Tab(
                    iconMargin: const EdgeInsets.only(bottom: 4),
                    icon: selectedIndex == 2
                        ? Image.asset(
                            "assets/icons/b3c.png",
                          )
                        : Image.asset(
                            "assets/icons/b3.png",
                          )),
                Tab(
                    iconMargin: const EdgeInsets.only(bottom: 4),
                    icon: selectedIndex == 3
                        ? Image.asset(
                            "assets/icons/b4c.png",
                          )
                        : Image.asset(
                            "assets/icons/b4.png",
                          )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
