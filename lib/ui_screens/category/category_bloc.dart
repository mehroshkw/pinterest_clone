import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinterest_clone/ui_screens/category/category_state.dart';
import '../../network_provider/photos_model.dart';
import 'package:http/http.dart' as http;

class CategoryBloc extends Cubit<CategoryState> {
  CategoryBloc():super(const CategoryState.initial());

  List<Photos> newsModel = [];
  Future<Photos?> getCatApi(String category) async{
    final response = await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$category&per_page=30&page=1"),
        headers: {"Authorization": "563492ad6f917000010000012876927f901846cd8b5d658bbe09bcda"});
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      return Photos.fromJson(data);
    }else{
      return Photos.fromJson(data);
    }
  }
}
