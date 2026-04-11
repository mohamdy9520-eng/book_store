
import 'dart:math';

import 'package:book_store/features/home/data/models/best_seller_response.dart';
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
  static Future<BestSellerResponse?> getBestSeller()async{
    try{
      final response=await DioHelper.dio?.get(ApiConstants.bestSeller);
      if(response?.statusCode==200){
        BestSellerResponse data=BestSellerResponse.fromJson(response?.data);
        return data;
      }else{
        return null;
      }
    }catch(e){
      return null;
    }
  }

}
