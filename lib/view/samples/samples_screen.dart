import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/sample_screen_controller.dart';
import 'package:vc/theme/constant/sized.dart';
import 'package:vc/view/payment/payment_method_screen.dart';

import 'package:vc/widgets/custom_text_next_button.dart';
import '../../model/services_model/user_home_model.dart';
import '../../widgets/custom_app_bar.dart';
import 'add_image.dart';
import 'image_card.dart';

class SamplesScreen extends StatefulWidget {
  final Service serviceModel;
  final Map orderData;
  const SamplesScreen(
      {Key? key, required this.serviceModel, required this.orderData})
      : super(key: key);

  @override
  State<SamplesScreen> createState() => _SamplesScreenState();
}

class _SamplesScreenState extends State<SamplesScreen> {
  @override
  void initState() {
    super.initState();
  }

  final _sampleScreenController = Get.put(SampleScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.85),
      body: Column(
        children: [
          CustomAppbar(
            image: setImage(),
            serviceName: widget.serviceModel.title,
            rating: widget.serviceModel.rate.toDouble(),
          ),
          Container(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 30).r,
            // width: size.width,
            // height: screenUtil.setHeight(511),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ).r,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Picture'.tr,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: screenUtil.setHeight(15),
              ),
              Text(
                'Please upload some samples'.tr,
                style: TextStyle(fontSize: 20.sp, color: Colors.grey),
              ),
              SizedBox(
                height: screenUtil.setHeight(10),
              ),
              GetBuilder<SampleScreenController>(
                builder: (_) => SizedBox(
                  height: screenUtil.setHeight(390),
                  child: GridView.count(
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                      children: [
                        ...List.generate(
                            _sampleScreenController.samplesImages.length,
                            (index) {
                          return ImageCard(
                            filePath: _sampleScreenController
                                .samplesImages[index].path,
                          );
                        }),
                        const AddImage()
                      ]),
                ),
              )
            ]),
          ),
        ],
      ),
      bottomNavigationBar: CustomTextNextButton(
        totalPrice: widget.orderData['totalPrice'].toString(),
        onTap: () {
          final List<String> imagesList = [];
          for (var element in _sampleScreenController.samplesImages) {
            imagesList.add(element.path);
          }
          widget.orderData.addAll({'gallery': imagesList});
          Get.to(
            () => PaymentMethodScreen(
              orderData: widget.orderData,
              serviceInfo: widget.serviceModel,
            ),
            transition: Transition.leftToRight,
            duration: const Duration(milliseconds: 1000),
          );
        },
      ),
    );
  }

  dynamic setImage() {
    if (widget.serviceModel.images.length > 1 &&
        widget.serviceModel.images.contains('http')) {
      return NetworkImage(widget.serviceModel.images);
    } else {
      return const AssetImage('assets/icons/cleaning 1.png');
    }
  }
}

// List<dynamic> images = [];
