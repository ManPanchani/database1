class Products {
  String? id;
  String? name;
  String? categoryName;
  String? price;
  String? image;
  String? averageRating;

  Products({
   required this.id,
   required this.name,
   required this.categoryName,
   required this.price,
   required this.image,
   required this.averageRating,
  });

  factory Products.fromMap(Map data) {
    return Products(
      id: data['Id'],
      name: data['Name'],
      categoryName: data['CategoryName'],
      price: data['Price'],
      image: data['Image'],
      averageRating: data['AverageRating'],
    );
  }
}

class ProductsDB {
  int? id;
  String? name;
  String? categoryName;
  int? price;
  String? image;
  int? averageRating;

  ProductsDB({
   required this.id,
   required this.name,
   required this.categoryName,
   required this.price,
   required this.image,
   required this.averageRating,
  });

  factory ProductsDB.fromMap(Map data) {
    return ProductsDB(
      id: data['Id'],
      name: data['Name'],
      categoryName: data['CategoryName'],
      price: data['Price'],
      image: data['Image'],
      averageRating: data['AverageRating'],
    );
  }
}
