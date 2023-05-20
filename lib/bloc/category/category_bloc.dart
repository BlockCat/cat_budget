import 'package:bloc/bloc.dart';
import 'package:cat_budget/models/category.dart';
import 'package:cat_budget/models/category_group.dart';
import 'package:meta/meta.dart';

import '../../repository/category.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;

  CategoryBloc(this._categoryRepository) : super(CategoryInitial()) {
    on<SaveCategoriesEvent>(_saveCategoryGroups);
  }

  Future<void> _saveCategoryGroups(
      SaveCategoriesEvent event, Emitter<CategoryState> emit) async {
    var groups = event.groups.map((e) async {
      if (e.deleted) {
        if (e.id != null) {
          // Delete group
          await _categoryRepository.deleteGroup(e.id!);
          // Then delete categories
          await _categoryRepository.deleteCategories(
              e.categories.where((element) => e.id != null).map((e) => e.id!));
          return null;
        } else {
          throw Exception('Cannot delete a group that has not been saved');
        }
      } else if (e.id == null) {
        // Create new group
        CategoryGroup group = await _categoryRepository.createGroup(
            CategoryGroup(id: -1, name: e.name, categories: const []));
        assert(group.id >= 0, 'Group ID must be greater than or equal to 0');
        // Then create/update/delete categories
        final categories = await _saveUpdateCategories(group, e.categories);

        return CategoryGroup(
            id: group.id, name: group.name, categories: categories);
      } else {
        // Update group
        final group = await _categoryRepository.updateGroup(
            CategoryGroup(id: e.id!, name: e.name, categories: const []));
        // Then create/update/delete categories
        return CategoryGroup(
            id: e.id!,
            name: e.name,
            categories: await _saveUpdateCategories(group, e.categories));
      }
    }).toList();

    emit(CategoryState(
        groups: await Future.wait(groups).then((value) => value
            .where((element) => element != null)
            .map((e) => e!)
            .toList())));
  }

  Future<List<Category>> _saveUpdateCategories(
      CategoryGroup group, List<SaveCategory> categories) {
    return Future.value([]);
  }
}
