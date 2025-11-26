class Category {
  String idCategory;
  String strCategory;
  String strCategoryThumb;
  String strCategoryDescription;

  Category(
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  );

  Category.fromJson(Map<String, dynamic> data)
    : idCategory = data['idCategory'],
      strCategory = data['strCategory'],
      strCategoryThumb = data['strCategoryThumb'],
      strCategoryDescription = data['strCategoryDescription'];

  Map<String, dynamic> toJson() => {
    'idCategory': idCategory,
    'strCategory': strCategory,
    'strCategoryThumb': strCategoryThumb,
    'strCategoryDescription': strCategoryDescription,
  };
}
