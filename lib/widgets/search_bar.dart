import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:vc/model/top_service_model.dart';
import 'package:vc/theme/constant/const_colors.dart';
import 'package:vc/widgets/action_card.dart';

import '../model/services_model/user_home_model.dart';

class SearchBar extends StatelessWidget {
  final List<Service>? shearchServiceLsit;
  final double? iconSize;
  const SearchBar({
    super.key,
    required this.screenUtil,
    this.shearchServiceLsit,
    this.iconSize = 35,
  });

  final ScreenUtil screenUtil;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: screenUtil.setHeight(100),
        child: TypeAheadField<Service>(
          textFieldConfiguration: TextFieldConfiguration(
            style: DefaultTextStyle.of(context)
                .style
                .copyWith(fontStyle: FontStyle.italic),
            decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.search_outlined,
                color: ColorApp.primary,
                size: iconSize,
              ),
              hintText: 'find it here ..........'.tr,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green.shade200, width: 2),
                borderRadius: BorderRadius.circular(10).w,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10).w,
                borderSide: BorderSide(color: Colors.green.shade200, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10).w,
                borderSide: const BorderSide(width: 1, color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10).w,
                borderSide: const BorderSide(width: 1, color: Colors.red),
              ),
              contentPadding: const EdgeInsets.fromLTRB(22, 18, 22, 18).r,
              hintStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
              ),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          suggestionsCallback: (pattern) async {
            return shearchServiceLsit!.where((element) {
              return element.title.contains(pattern);
            });
          },
          itemBuilder: (context, suggestion) {
            return ActionCard(
                width: 40.w,
                topServiceModel: TopServiceModelCard(
                    title: suggestion.title,
                    image: suggestion.images,
                    rate: suggestion.rate.toDouble(),
                    price: suggestion.price.toDouble(),
                    id: suggestion.id,
                    is_favorite: suggestion.isFavorite),
                serviceModel: suggestion);
          },
          onSuggestionSelected: (suggestion) {
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => ProductPage(product: suggestion)
            // ));
          },
        ));
  }
}
