import 'package:get/get.dart';
import 'package:vc/model/auth/profile_model.dart';
import 'package:vc/services/auth_service/profile_service.dart';

class ProfileController extends GetxController {
  Future<ProfileModel?> getProfileData() async {
    final data = await ProfileService().profile();
    if (data['statusCode'] == 200) {
      return ProfileModel.fromJson(data);
    }
    return null;
  }
}
