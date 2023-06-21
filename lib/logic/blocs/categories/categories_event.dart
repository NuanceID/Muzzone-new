abstract class CategoriesEvent {
  const CategoriesEvent();
}

class GetFindCategory extends CategoriesEvent {
  final String name;

  const GetFindCategory({required this.name});
}

class GetMoreCategories extends CategoriesEvent {
  final String page;

  const GetMoreCategories({required this.page});
}

class GetCategories extends CategoriesEvent {
  const GetCategories();
}

class GetCategory extends CategoriesEvent {
  final String categoryId;

  const GetCategory({required this.categoryId});
}
