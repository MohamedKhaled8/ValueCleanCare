import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/animation/loder.dart';
import 'package:vc/controller/animation_controller.dart';
import 'package:vc/theme/constant/const_colors.dart';
import 'package:vc/view/auth_view/signup_view.dart';
import 'package:vc/view/transport_view/transport_companies.dart';
import 'package:vc/view/auth_view/auth_view.dart';
import 'package:vc/view/home_view/bottom_nav_bar.dart';
import '../../controller/auth/login_controller.dart';
import '../../theme/constant/sized.dart';
import '../../widgets/arrow_back_icons.dart';
import '../../widgets/custom_textform_field.dart';
import '../../widgets/custom_textformfied _password.dart';
import '../../widgets/cutom_buttom_two.dart';
import '../user_profile/shipping_company_profile.dart';
import 'forgot_password_screen.dart';

class LoginView extends StatelessWidget {
  final String? passEmail;
  final String? passpassword;
  LoginView({super.key, this.passEmail, this.passpassword});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Animation_Controller _animationController =
      Get.put(Animation_Controller());
  final LoginController _loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    _loginController.email.text = passEmail ?? '';
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<Animation_Controller>(
          builder: (_) => Loder(
            loder: _animationController.loderShow,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 10)
                            .r,
                    child: ArrowBackIcon(
                      ontap: () {
                        Get.to(const AuthAppView());
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15).r,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                              "assets/icons/152 - 38 Valu Clean Care Site Logo 02.png"),
                          SizedBox(
                            height: screenUtil.setHeight(10),
                          ),
                          Image.asset(
                            "assets/icons/626 - 626 Character Valu Clean.png",
                            height: screenUtil.setHeight(270),
                            width: screenUtil.setHeight(310),
                          ),
                          SizedBox(
                            height: screenUtil.setHeight(15),
                          ),
                          Text(
                            'Welcome back'.tr,
                            style: TextStyle(
                                fontSize: 26.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorApp.primary),
                          ),
                          SizedBox(
                            height: screenUtil.setHeight(10),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    CustomTextFormField(
                                      controller: _loginController.email,
                                      type: TextInputType.emailAddress,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Filed Required';
                                        }
                                        return null;
                                      },
                                      text: 'Enter email'.tr,
                                      fieldName: 'email'.tr,
                                    ),
                                    SizedBox(
                                      height: screenUtil.setHeight(20),
                                    ),
                                    CustomTextFormFieldPassword(
                                      text: 'Enter password'.tr,
                                      controllerTwo: _loginController.password,
                                    ),
                                    SizedBox(height: screenUtil.setHeight(10)),
                                    GetBuilder<LoginController>(builder: (_) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Expanded(
                                              child: CheckboxListTile(
                                                contentPadding: EdgeInsets.zero,
                                                value:
                                                    _loginController.isCheckBox,
                                                onChanged: (value) {
                                                  _loginController
                                                      .isCheckBoxes();
                                                },
                                                title: Text(
                                                  'Remember me'.tr,
                                                  style: TextStyle(
                                                      fontSize: 15.sp),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(
                                                  ForgotPasswordView(),
                                                  duration: const Duration(
                                                      milliseconds: 1000),
                                                  transition:
                                                      Transition.rightToLeft,
                                                );
                                              },
                                              child: Text(
                                                'forgot password ?'.tr,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Don\'t have account ?'.tr,
                                          style: TextStyle(
                                              color: ColorApp.primary,
                                              fontSize: 18.sp),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.to(SignUpView());
                                          },
                                          child: Text(
                                            'Sign Up'.tr,
                                            style: TextStyle(
                                                color: ColorApp.primary,
                                                fontSize: 18.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenUtil.setHeight(10)),
                                    CustomButtonTWo(
                                      onTap: () async {
                                        try {
                                          _animationController.loder();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            final status =
                                                await _loginController.login(
                                              context: context,
                                              remember:
                                                  _loginController.isCheckBox,
                                            );
                                            if (status != null &&
                                                status.success &&
                                                status.userData.type ==
                                                    'user') {
                                              Get.offAll(
                                                () => const BottomNavBar(),
                                                transition: Transition.zoom,
                                                duration: const Duration(
                                                    milliseconds: 1000),
                                              );
                                            } else if (status != null &&
                                                status.success &&
                                                status.userData.type ==
                                                    'client-company') {
                                              Get.offAll(
                                                () =>
                                                    TransportCompaniesScreen(),
                                                transition: Transition.zoom,
                                                duration: const Duration(
                                                    milliseconds: 1000),
                                              );
                                            } else if (status != null &&
                                                status.success &&
                                                status.userData.type ==
                                                    'company ' &&
                                                status.userData.approved ==
                                                    true) {
                                              Get.offAll(
                                                () =>
                                                    ShippingClientProfileScreen(),
                                                transition: Transition.zoom,
                                                duration: const Duration(
                                                    milliseconds: 1000),
                                              );
                                            }
                                          }
                                        } finally {
                                          _animationController.loder();
                                        }
                                      },
                                      screenUtil: screenUtil,
                                      txt: 'Login'.tr,
                                      color: ColorApp.primary,
                                      color1: Colors.white,
                                    ),

                                    // SizedBox(height: screenUtil.setHeight(20)),
                                    // Row(
                                    //   children: [
                                    //     Expanded(
                                    //         child: Divider(
                                    //       height: screenUtil.setHeight(20),
                                    //       color: Colors.black,
                                    //     )),
                                    //     Text(
                                    //       "  OR SIGN IN WITH  ".tr,
                                    //       style: TextStyle(fontSize: 16.sp),
                                    //     ),
                                    //     Expanded(
                                    //         child: Divider(
                                    //       height: screenUtil.setHeight(20),
                                    //       color: Colors.black,
                                    //     )),
                                    //   ],
                                    // ),
                                    // SizedBox(height: screenUtil.setHeight(10)),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceEvenly,
                                    //   children: [
                                    //     InkWell(
                                    //         onTap: () async {
                                    //           if (await checkInternetConnection()) {
                                    //             try {
                                    //               _animationController.loder();

                                    //               await FirebaseAuth.instance
                                    //                   .signOut();

                                    //               // Trigger the authentication flow
                                    //               final GoogleSignInAccount?
                                    //                   googleUser =
                                    //                   await GoogleSignIn()
                                    //                       .signIn();

                                    //               // Obtain the auth details from the request
                                    //               final GoogleSignInAuthentication?
                                    //                   googleAuth =
                                    //                   await googleUser
                                    //                       ?.authentication;
                                    //               // Create a new credential
                                    //               final credential =
                                    //                   GoogleAuthProvider
                                    //                       .credential(
                                    //                 accessToken:
                                    //                     googleAuth?.accessToken,
                                    //                 idToken:
                                    //                     googleAuth?.idToken,
                                    //               );

                                    //               // ignore: use_build_context_synchronously
                                    //               final status = await Google_Signin()
                                    //                   .googleSignIn(
                                    //                       context: context,
                                    //                       accessToken: googleAuth
                                    //                               ?.accessToken ??
                                    //                           '');

                                    //               if (status != null &&
                                    //                   status.success &&
                                    //                   status.userData.type ==
                                    //                       'user') {
                                    //                 await FirebaseAuth.instance
                                    //                     .signInWithCredential(
                                    //                         credential);
                                    //                 Get.offAll(
                                    //                   () =>
                                    //                       const BottomNavBar(),
                                    //                   transition:
                                    //                       Transition.zoom,
                                    //                   duration: const Duration(
                                    //                       milliseconds: 1000),
                                    //                 );
                                    //               } else if (status != null &&
                                    //                   status.success &&
                                    //                   status.userData.type !=
                                    //                       'user') {
                                    //                 await FirebaseAuth.instance
                                    //                     .signInWithCredential(
                                    //                         credential);
                                    //                 Get.offAll(
                                    //                   () =>
                                    //                       TransportCompaniesScreen(),
                                    //                   transition:
                                    //                       Transition.zoom,
                                    //                   duration: const Duration(
                                    //                       milliseconds: 1000),
                                    //                 );
                                    //               }
                                    //             } on PlatformException catch (e) {
                                    //               if (e.code ==
                                    //                   GoogleSignIn
                                    //                       .kNetworkError) {
                                    //                 String errorMessage =
                                    //                     "A network error (such as timeout, interrupted connection or unreachable host) has occurred."
                                    //                         .tr;
                                    //                 // ignore: use_build_context_synchronously
                                    //                 ShowBanner.showBanner(
                                    //                     context: context,
                                    //                     text: errorMessage);
                                    //               } else {
                                    //                 String errorMessage =
                                    //                     "Something went wrong."
                                    //                         .tr;

                                    //                 // ignore: use_build_context_synchronously
                                    //                 ShowBanner.showBanner(
                                    //                     context: context,
                                    //                     text: errorMessage);
                                    //               }
                                    //             } catch (error) {
                                    //               // ignore: use_build_context_synchronously
                                    //               ShowBanner.showBanner(
                                    //                   context: context,
                                    //                   text:
                                    //                       'some thing went wrong');
                                    //             } finally {
                                    //               _animationController.loder();
                                    //             }
                                    //           } else {
                                    //             // ignore: use_build_context_synchronously
                                    //             ShowBanner.showBanner(
                                    //                 context: context,
                                    //                 text:
                                    //                     'Check Your Internet Connection!');
                                    //           }
                                    //         },
                                    //         child: Image.asset(
                                    //             "assets/icons/Google.png")),
                                    //     InkWell(
                                    //         onTap: () async {
                                    //           if (await checkInternetConnection()) {
                                    //             try {
                                    //               _animationController.loder();

                                    //               await FirebaseAuth.instance
                                    //                   .signOut();

                                    //               // Trigger the sign-in flow
                                    //               final LoginResult
                                    //                   loginResult =
                                    //                   await FacebookAuth
                                    //                       .instance
                                    //                       .login();

                                    //               if (loginResult.accessToken !=
                                    //                   null) {
                                    //                 // Create a credential from the access token
                                    //                 final OAuthCredential
                                    //                     facebookAuthCredential =
                                    //                     FacebookAuthProvider
                                    //                         .credential(
                                    //                             loginResult
                                    //                                 .accessToken!
                                    //                                 .token);

                                    //                 // ignore: use_build_context_synchronously
                                    //                 final status =
                                    //                     // ignore: use_build_context_synchronously
                                    //                     await Facebook_Signin()
                                    //                         .facebbokSignin(
                                    //                             context:
                                    //                                 context,
                                    //                             accessToken:
                                    //                                 loginResult
                                    //                                     .accessToken!
                                    //                                     .token);

                                    //                 if (status != null &&
                                    //                     status.success &&
                                    //                     status.userData.type ==
                                    //                         'user') {
                                    //                   // Once signed in, return the UserCredential
                                    //                   FirebaseAuth.instance
                                    //                       .signInWithCredential(
                                    //                           facebookAuthCredential);

                                    //                   Get.offAll(
                                    //                     () =>
                                    //                         const BottomNavBar(),
                                    //                     transition:
                                    //                         Transition.zoom,
                                    //                     duration:
                                    //                         const Duration(
                                    //                             milliseconds:
                                    //                                 1000),
                                    //                   );
                                    //                 } else if (status != null &&
                                    //                     status.success &&
                                    //                     status.userData.type !=
                                    //                         'user') {
                                    //                   // Once signed in, return the UserCredential
                                    //                   FirebaseAuth.instance
                                    //                       .signInWithCredential(
                                    //                           facebookAuthCredential);
                                    //                   Get.offAll(
                                    //                     () =>
                                    //                         TransportCompaniesScreen(),
                                    //                     transition:
                                    //                         Transition.zoom,
                                    //                     duration:
                                    //                         const Duration(
                                    //                             milliseconds:
                                    //                                 1000),
                                    //                   );
                                    //                 }
                                    //               }
                                    //             } on PlatformException catch (e) {
                                    //               if (e.code ==
                                    //                   GoogleSignIn
                                    //                       .kNetworkError) {
                                    //               } else {
                                    //                 String errorMessage =
                                    //                     "Something went wrong."
                                    //                         .tr;
                                    //                 // ignore: use_build_context_synchronously
                                    //                 ShowBanner.showBanner(
                                    //                     context: context,
                                    //                     text: errorMessage);
                                    //               }
                                    //             } catch (error) {
                                    //               // ignore: use_build_context_synchronously
                                    //               // ignore: use_build_context_synchronously
                                    //               ShowBanner.showBanner(
                                    //                   context: context,
                                    //                   text:
                                    //                       "Something went wrong.");
                                    //             } finally {
                                    //               _animationController.loder();
                                    //             }
                                    //           }
                                    //         },
                                    //         child: Image.asset(
                                    //             "assets/icons/facebook.png")),
                                    //   ],
                                    // ),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
