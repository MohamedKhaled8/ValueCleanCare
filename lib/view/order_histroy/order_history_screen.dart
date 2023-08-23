import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/order/order_controller.dart';
import 'package:vc/view/order_histroy/tab1.dart';
import 'package:vc/view/order_histroy/tab2.dart';
import 'package:vc/view/order_histroy/tab3.dart';
import '../../theme/constant/const_colors.dart';
import '../../theme/constant/sized.dart';
import '../../widgets/custom_containert_top_screen.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabControllerTwo;
  final OrderController finishedOrderController = OrderController();

  int selectedIndex = 0;
  @override
  void initState() {
    finishedOrderController.finishOrder(context: context);
    _tabControllerTwo = TabController(length: 3, vsync: this);
    super.initState();
  }

  List<Widget> myPagesTwo = [
    Tab1Screen(),
    Tab2Screen(),
    Tab3Screen(),
  ];
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: const Color(0xffF4F4F4),
          body: Stack(
            children: [
              CustomContainerTopScreen(
                size: 130,
                screenUtil: screenUtil,
                text: 'Order History'.tr,
                ontap: () {
                  Get.back();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 125).r,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: TabBar(
                      onTap: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      isScrollable: true,
                      controller: _tabControllerTwo,
                      labelColor: ColorApp.primary,
                      unselectedLabelColor: Colors.grey,
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                          color: ColorApp.primary,
                          width: 3,
                        ),
                      ),
                      tabs: [
                        Tab(
                          child: Text(
                            "Current".tr,
                            style: TextStyle(fontSize: 20.sp),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Cancelled".tr,
                            style: TextStyle(fontSize: 20.sp),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Finished".tr,
                            style: TextStyle(fontSize: 20.sp),
                          ),
                        ),
                      ]),
                ),
              ),
              TabBarView(
                controller: _tabControllerTwo,
                children: myPagesTwo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
