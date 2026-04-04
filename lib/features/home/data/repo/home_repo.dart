
import 'package:flutter/material.dart';

import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/dio.helper.dart';
import '../models/model_slider.dart';

class HomeRepo {



  static Future<SliderResponse?>? getSlider()async{

    try{
      final response=await DioHelper.dio?.get(ApiConstants.slider);
      if(response?.statusCode==200){
        SliderResponse data=SliderResponse.fromJson(response?.data);
        return data;
      }else{
        return null;
      }
    }catch(error){
      return null;
    }


  }

}
