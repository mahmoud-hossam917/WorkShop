import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testmahmoud/Models/TermsModel.dart';
import 'package:testmahmoud/ViewModel/Terms_Cubit/TermsState.dart';
import 'package:testmahmoud/Views/Component/catchError.dart';
import 'package:testmahmoud/database/remote/dioHelper.dart';

import '../endpoints.dart';

class TermsCubit extends Cubit<TermsState>{
  TermsCubit():super(TermsInit());

  static TermsCubit GetInstance(context)=>BlocProvider.of(context);
  TermsModel? termsModel;
  GetTerms()async {
    emit(TermsLoading());
    try {
      await DioHelper.GetData(url: terms).then((value) {
        emit(TermsSuccess());
        termsModel=TermsModel.fromjeson(data: value.data);


      });
    }on DioError catch (error) {

      return CatchError(error);
    }
  }
}