class CategoryModel{
  final String? categorieName;
  final String? imageAssetUrl;

  CategoryModel({required this.categorieName,required this.imageAssetUrl});
}

List<CategoryModel> categoryDetails = [

  CategoryModel(
    categorieName: 'Street Art',
    imageAssetUrl: 'https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
  ),

  CategoryModel(
    categorieName: 'Wild Life',
    imageAssetUrl: 'https://images.pexels.com/photos/704320/pexels-photo-704320.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
  ),

  CategoryModel(
    categorieName: 'Nature',
    imageAssetUrl: 'https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500',
  ),

  CategoryModel(
      categorieName: 'City',
      imageAssetUrl: 'https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500'
  ),

  CategoryModel(
    categorieName: 'Motivation',
    imageAssetUrl: 'https://images.pexels.com/photos/1434819/pexels-photo-1434819.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260',
  ),
  CategoryModel(
    categorieName: 'Bikes',
    imageAssetUrl: 'https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
  ),
  CategoryModel(
    categorieName: 'Cars',
    imageAssetUrl: 'https://images.pexels.com/photos/1149137/pexels-photo-1149137.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
  ),
];