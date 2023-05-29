import 'package:flutter/material.dart';
import '../../../network_provider/category_model.dart';
import '../../reusable_widgets/app_text_field.dart';
import '../../reusable_widgets/category_tile.dart';

class SearchScreen extends StatelessWidget {
  static const String key_title = '/search';
  // String category;
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryModel? categoryModel;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 60,),
            const AppTextField(hint: 'Search', textInputType: TextInputType.text, isError: false,
            suffixIcon: Icon(Icons.photo_camera), prefixIcon: Icon(Icons.search_sharp),
            ),
            Expanded(
              child: Container(
                // height: 70,
                child:  GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate:
                    const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200 ,
                        childAspectRatio: 6/3,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0),
                    itemCount: categoryDetails.length,
                    itemBuilder: (context, index) {
                      return CategoryCard(
                        imageAssetUrl: categoryDetails[index].imageAssetUrl!,
                        categoryName: categoryDetails[index].categorieName!,
                      );
                    })
              ),
            ),
          ],
        ),
      ),
    );
  }
}