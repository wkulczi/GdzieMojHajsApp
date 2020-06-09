import 'package:gdziemojhajsapp/logic/Controllers/account_controller.dart';
import 'package:gdziemojhajsapp/pages/Categories/limit_state.dart';
import 'package:gdziemojhajsapp/pages/Menu/budget_limits_state.dart';
import 'package:provider/provider.dart';

import 'Controllers/category_controller.dart';

class Utility {
  //todo poprawić to, żeby nie robiło 14 zapytań do bazy danych!
  static void reloadStates(context) async {
    final CategoriesState categoriesState = Provider.of<CategoriesState>(context, listen: false);
    final LimitsState limitsState = Provider.of<LimitsState>(context, listen: false);
    categoriesState.categories = await CategoryController.getData();
    limitsState.daily = await getDaily();
    limitsState.monthly = await getMonthly();
    limitsState.monthly_left = await getMonthlyLeft();
    limitsState.daily_left = await getDailyLeft();
    print("DEB: ready");
  }
}
