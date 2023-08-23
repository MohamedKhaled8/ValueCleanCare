import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/model/company/all_compaany_model.dart';
import 'package:vc/theme/constant/sized.dart';
import 'package:vc/view/transport_view/transport_card_widgets.dart';
import '../../controller/company/get_company_controller.dart';
import '../../model/transport_companies_model.dart';
import '../../widgets/default_appBar.dart';

class TransportCompaniesSeeAll extends StatelessWidget {
  TransportCompaniesSeeAll({super.key});
  final GetCompanyController getCompanyController = GetCompanyController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DefaultAppBar(
          size: screenUtil.setHeight(130),
          ontap: () {
            Get.back();
          },
          screenUtil: screenUtil,
          text: 'Transport companies'.tr,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenUtil.setHeight(20),
              ),
              FutureBuilder(
                future: getCompanyController.allCompany(context: context),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    final AllCompanyModel companyModel =
                        snapshot.data as AllCompanyModel;
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return TransportCard(
                          data: companyModel.data![index],
                          transportcompaniesmodel: TransportCompaniesModel(
                              image: companyModel.data![index].photo,
                              title: companyModel.data![index].name),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox();
                      },
                      itemCount: companyModel.data!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
