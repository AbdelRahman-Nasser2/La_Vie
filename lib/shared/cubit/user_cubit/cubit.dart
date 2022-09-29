import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/models/user_model.dart';
import 'package:la_vie/shared/components/components.dart';
import 'package:la_vie/shared/components/constant.dart';
import 'package:la_vie/shared/cubit/user_cubit/states.dart';
import 'package:la_vie/shared/network/local/sharedpreference/sharedpreference.dart';
import 'package:la_vie/shared/network/remote/dio_Helper/dio_Helper.dart';
import 'package:la_vie/shared/network/remote/end_points.dart';

class UserDataCubit extends Cubit<UserDataStates> {
  UserDataCubit() : super(UserDataInitialState());
  static UserDataCubit get(context) => BlocProvider.of(context);

  var formKeyEmail = GlobalKey<FormState>();
  var formKeyName = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();




  CurrentUserModel? userCurrentModel;

  void getUserData() {
    emit(UserGetDataLoading());
    DioHelper.getData(
      url: CRRENTUSER,
      token: refreshToken,
    ).then((value) {
      userCurrentModel = CurrentUserModel.fromJson(value.data);
      CacheHelper.saveData(
          key: "userId", value: userCurrentModel?.data!.userId);
      CacheHelper.saveData(
          key: "firstName", value: userCurrentModel?.data!.firstName);
      CacheHelper.saveData(
          key: "lastName", value: userCurrentModel?.data!.lastName);
      CacheHelper.saveData(key: "email", value: userCurrentModel?.data!.email);
      CacheHelper.saveData(
          key: "imageUrl", value: userCurrentModel?.data!.imageUrl);
      CacheHelper.saveData(key: "role", value: userCurrentModel?.data!.role);
      print(userCurrentModel!.data!.firstName );
      print(token);

      emit(UserGetDataSuccess());
    }).catchError((error) {
      emit(UserGetDataError(error.toString()));
    });
  }



  void updateUserName({
     required dynamic firstValue,
    required dynamic lastValue}) {
    emit(UpdateUserNameLoading());
    DioHelper.patchData(url: UPDATEUSER, data: {
      'firstName':firstValue,
      'lastName':lastValue
      }, token: token!)
        .then((value) {
      emit(UpdateUserNameSuccess());
    }).catchError((error) {
      emit(UpdateUserNameError(error));
    });
  }



  void updateUserEmail({required String key, required dynamic value}) {
    emit(UpdateUserEmailLoading());
    DioHelper.patchData(url: UPDATEUSER, data: {key: value}, token: token!)
        .then((value) {
      emit(UpdateUserEmailSuccess());
    }).catchError((error) {
      emit(UpdateUserEmailError(error));
    });
  }



  void signOut(context, widget) {
    CacheHelper.removeData(key: 'token').then((value) {
      if (value!) {
        navigateAndFinish(context, widget);
        showToast(text: 'LogOut', state: ToastStates.WARNING);
      }
    });
  }


}