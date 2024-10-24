abstract class CategoryEvent{
  const CategoryEvent();

  List<Object> get props => [];
}

class LoadCategories extends CategoryEvent {
  const LoadCategories();
}
