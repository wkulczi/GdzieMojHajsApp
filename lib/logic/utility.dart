import 'package:gdziemojhajsapp/pages/Categories/limit_state.dart';
import 'package:provider/provider.dart';

import 'Controllers/category_controller.dart';

class Utility {

  static void reloadStates(context) async {
    final CategoriesState categoriesState = Provider.of<CategoriesState>(context, listen: false);
    categoriesState.categories = await CategoryController.getData();
    print("DEB: ready");
  }
}
