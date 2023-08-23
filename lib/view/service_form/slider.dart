import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/controller/service_form_controller.dart';

import '../../theme/constant/const_colors.dart';

class SlideView extends StatefulWidget {
  final RangeValues workArea;
  const SlideView({Key? key, this.workArea = const RangeValues(10, 25)})
      : super(key: key);

  @override
  State<SlideView> createState() => _SlideViewState();
}

class _SlideViewState extends State<SlideView> {
  RangeValues? currentRangeValue;

  @override
  void initState() {
    super.initState();
    currentRangeValue = widget.workArea;
  }

  @override
  Widget build(BuildContext context) {
    final serviceController = Get.put(ServiceFormController());
    serviceController.workArea = currentRangeValue;
    return RangeSlider(
        activeColor: ColorApp.primary,
        inactiveColor: ColorApp.primary.withOpacity(0.2),
        labels: RangeLabels(currentRangeValue!.start.round().toString(),
            currentRangeValue!.end.round().toString()),
        values: currentRangeValue!,
        max: 250,
        min: 1,
        divisions: 100,
        onChanged: (RangeValues values) {
          serviceController.workArea = values;
          setState(() {
            currentRangeValue = values;
          });
        });
  }
}
