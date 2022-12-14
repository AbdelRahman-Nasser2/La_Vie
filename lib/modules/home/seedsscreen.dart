import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:la_vie/shared/components/components.dart';
import 'package:la_vie/shared/cubit/appCubit/cubit.dart';
import 'package:la_vie/shared/cubit/appCubit/states.dart';

class SeedsScreen extends StatelessWidget {
  const SeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getDataSeeds(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {},
          builder: (BuildContext context, AppStates state) {
            var list = AppCubit.get(context);
            var model = list.seedModel;
            return ConditionalBuilder(
              condition: state is! SeedsGetDataLoading?true:false,
              fallback: (BuildContext context) => Center(
                child: CircularProgressIndicator(
                  color: HexColor("#1ABC00"),
                ),
              ),
              builder: (BuildContext context) {
                return buildCategoryList(model!);
              },
            );
          }),
    );
  }
}
