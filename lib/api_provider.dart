import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:technupur_test/models/product_model.dart';
import 'package:http/http.dart' as http;

class ApiProvider with ChangeNotifier{
  List<ProductModel>? productModelList;
  bool isLoading = false;
  int selectedCategoryIndex = 0;
  int selectedSubCategoryIndex = 0;


  addToFavorite(int index){
    productModelList![selectedCategoryIndex].subCategory![selectedSubCategoryIndex].products![index].isFavorite = !productModelList![selectedCategoryIndex].subCategory![selectedSubCategoryIndex].products![index].isFavorite!;
    notifyListeners();
  }


  Future getProducts()async{
    isLoading = true;
    notifyListeners();
    var response  = await http.get(Uri.parse('https://tp-flutter-test.vercel.app/v1/category'));
    if(response.statusCode==200){
      productModelList = (json.decode(response.body) as List).map((e) => ProductModel.fromJson(e)).toList();
      isLoading = false;
      notifyListeners();
    }else{
      throw Exception('Failed to load data');
    }
  }
}