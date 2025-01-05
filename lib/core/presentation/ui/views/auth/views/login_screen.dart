import 'package:flutter/material.dart';

import '../../../shared_widgets/default_text.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Stack(
          children: [
            Column(
              children: [
                const CustomLoginAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(20.h),
                          DefaultText(
                            data: AppStrings.loginTitle,
                            fontFamily: "Geist",
                            fontWeight: FontWeight.w900,
                            textColor: AppColors.white,
                            fontSize: 20.sp,
                            letterSpacing: -0.41,
                            lineHeight: 1.33,
                            textAlign: TextAlign.left,
                          ),
                          Gap(4.h),
                          DefaultText(
                            data: AppStrings.loginMessage,
                            fontFamily: "Geist",
                            fontWeight: FontWeight.w400,
                            textColor: AppColors.white,
                            fontSize: 16.sp,
                            letterSpacing: -0.41,
                            lineHeight: 1.33,
                            textAlign: TextAlign.left,
                          ),
                          Gap(40.h),
                          SignInForm(
                            formKey: _formKey,
                            passwordController: passwordCtrl,
                            emailController: emailCtrl,
                            phoneController: phoneCtrl,
                            onPasswordReset: (){},
                            countryController: countryCtrl,
                            countryNotifier: _countryNotifier,
                          ),
                          Gap(30.h),
                          DefaultButton(
                            onBtnTap: () async {
                              // if(_formKey.currentState!.validate()){
                              //   FocusManager.instance.primaryFocus?.unfocus();
                              //   final phoneNumber = phoneCtrl.text.trim();
                              //   Country? country = _countryNotifier.value;
                              //   authVm.phoneNumber =
                              //       '+${country?.phoneCode}${toNumericString(phoneNumber)}';
                              //   authVm.email = emailCtrl.text.trim();
                              //   authVm.password = passwordCtrl.text.trim();
                              //   authVm.country = country?.countryCode;
                              //   final success  = await authVm.loginUser(AuthMethod.password);
                              //   if(success){
                              //     Get.offAll(()=> const AppNavigation(), transition: Transition.cupertino);
                              //   }
                              // }
                              Get.offAll(()=> const AppNavigation(), transition: Transition.cupertino);
                            },
                            btnText: AppStrings.signIn,
                            btnColor: AppColors.white,
                            btnTextColor: AppColors.blackOA,
                          ),
                          Gap(10.h),
                          Center(
                            child: DefaultTextSpan(
                              title: AppStrings.noAccount,
                              actionTitle: "Sign in",
                              textAlign: TextAlign.center,
                              onPressed: (){
                                Get.off(()=> const SignUpScreen(), transition: Transition.cupertino);
                              },
                            ),
                          ),
                          Gap(20.h),
                          //add the or widget
                          const OrText(),
                          Gap(20.h),
                          DefaultButton(
                            onBtnTap: () async {
                              var success  = await authVm.loginUser(AuthMethod.google);
                              if(success){
                                Get.offAll(()=> const AppNavigation(), transition: Transition.cupertino);
                              }
                            },
                            btnText: AppStrings.googleLogin,
                            isIconPresent: true,
                            iconData: Media.google,
                            btnColor: AppColors.primaryColor,
                            btnTextColor: AppColors.white,
                          ),
                          Gap(10.h),
                          DefaultButton(
                            onBtnTap: ()async {
                              var success  = await authVm.registerUser(AuthMethod.facebook);
                              if(success){
                                Get.offAll(()=> const AppNavigation(), transition: Transition.cupertino);
                              }
                            },
                            btnText: AppStrings.facebookLogin,
                            isIconPresent: true,
                            iconData: Media.facebook,
                            btnColor: AppColors.primaryColor,
                            btnTextColor: AppColors.white,
                          ),
                          Gap(10.h),
                          DefaultButton(
                            onBtnTap: (){
                              // var success  = await authVm.registerUser(AuthMethod.google);
                              // if(success){
                              //   Get.offAll(()=> const AppNavigation(), transition: Transition.cupertino);
                              // }
                            },
                            btnText: AppStrings.appleLogin,
                            isIconPresent: true,
                            iconData: Media.apple,
                            btnColor: AppColors.primaryColor,
                            btnTextColor: AppColors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: authVm.isLoading,
              child: const Loader(),
            )
          ],
        ),
      ),
    );
  }
}
