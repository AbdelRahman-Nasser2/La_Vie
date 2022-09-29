import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:la_vie/layout/homeLayout/homeLayoutScreen.dart';
import 'package:la_vie/modules/login/login.dart';
import 'package:la_vie/shared/components/components.dart';

import 'package:la_vie/shared/cubit/user_cubit/states.dart';

import '../../shared/cubit/user_cubit/cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserDataCubit,  UserDataStates>(
        listener: (BuildContext context,  UserDataStates state) {},
        builder: (BuildContext context,  UserDataStates state) {

          var cubit = UserDataCubit.get(context);

          return ConditionalBuilder(
            condition: state is! UserGetDataLoading?true:false,
            builder: (BuildContext context) => SafeArea(
              child: Scaffold(
                extendBodyBehindAppBar: true,
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 300,
                            child: Image(
                              image: NetworkImage(
                                "${cubit.userCurrentModel!.data?.imageUrl}",
                              ),
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                              colorBlendMode: BlendMode.darken,
                              color: Colors.black87,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Align(
                              // heightFactor: 0,
                              alignment: Alignment.center,
                              child:  Column(
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  backgroundImage:
                                  NetworkImage("${cubit.userCurrentModel!.data?.imageUrl}"),
                                ),
                                Text(
                                  "${cubit.userCurrentModel!.data?.firstName} ${cubit.userCurrentModel!.data?.lastName}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 29),
                                )
                              ],
                            ),),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,

                          children: [
                            const SizedBox(
                              height: 14,
                            ),
                            Container(
                              height: 60,
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/icons/points.svg"),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text((cubit.userCurrentModel!.data?.userPoints == null)
                                      ? "You have 0 points"
                                      : "You have ${cubit.userCurrentModel!.data?.userPoints} points"),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Editing Profile",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: InkWell(
                                onTap: () {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Change Your Name "),
                                        content: SingleChildScrollView(
                                            child: Form(
                                          key: cubit.formKeyName,
                                          child: Column(
                                            children: [
                                              tffLogin(
                                                controller: cubit.firstNameController,
                                                input: TextInputType.name,
                                                validate: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return 'name must be not empty';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                              SizedBox(height: 10,),
                                              tffLogin(
                                                controller: cubit.lastNameController,
                                                input: TextInputType.name,
                                                validate: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return 'name must be not empty';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Save Changes'),
                                            onPressed: () {
                                              if (cubit.formKeyName.currentState!
                                                  .validate()) {
                                                cubit.updateUserName(
                                                    firstValue: cubit.firstNameController.text,
                                                    lastValue: cubit.lastNameController.text);
                                                navigateAndFinish(context, const HomeLayoutScreen());
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: SvgPicture.asset(
                                            "assets/icons/change.svg"),
                                      ),
                                      Text(
                                        "Change Name",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: HexColor("#2F2E2E"),
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(Icons.arrow_forward_ios),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: InkWell(
                                onTap: () {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Change Your Email "),
                                        content: SingleChildScrollView(
                                            child: Form(
                                          key:cubit.formKeyEmail,
                                          child: Column(
                                            children: [
                                              tffLogin(
                                                controller: cubit.emailController,
                                                input:
                                                    TextInputType.emailAddress,
                                                validate: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return 'email must be not empty';
                                                  } else if (!value
                                                          .toString()
                                                          .contains('@') ||
                                                      !value
                                                          .toString()
                                                          .contains('.com')) {
                                                    return 'ex: example@mail.com';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        )),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Save Changes'),
                                            onPressed: () {
                                              if (cubit.formKeyName.currentState!
                                                  .validate()) {
                                                cubit.updateUserEmail(
                                                    key: "email",
                                                    value:
                                                        cubit.emailController.text);
                                                Navigator.pop(context);
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: SvgPicture.asset(
                                            "assets/icons/change.svg"),
                                      ),
                                      Text(
                                        "Change Email",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: HexColor("#2F2E2E"),
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(Icons.arrow_forward_ios),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            defaultButton(
                              colorButton: Colors.red,
                                text: "LogOut",

                                ontap: () {
                                  // CacheHelper.removeData(key: "refreshToken");
                                  cubit.signOut(context, const MainLogin());
                                  // CacheHelper.removeData(key: "token")
                                 // .then(
                                 //      (value) => navigateAndFinish(
                                 //          context, const MainLogin()));
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            fallback: (BuildContext context) =>
                Center(child: CircularProgressIndicator(

                  color: HexColor("#1ABC00"),

                ),),
          );
        },);
  }
}
