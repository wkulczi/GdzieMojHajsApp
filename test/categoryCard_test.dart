import 'package:flutter_test/flutter_test.dart';
import 'package:gdziemojhajsapp/logic/Entities/Category.dart';
import 'package:gdziemojhajsapp/pages/Categories/categoryCard.dart';
import 'package:image_test_utils/image_test_utils.dart';

void main() {
   Category category = Category(name: "Jedzenie",
       image: 'http://10.0.2.2:5000/get_image/jedzenie.jpg',
       description: "W tej kategorii znajdują się dane dotyczace środków wydanych na jedzenie."
   );
   testWidgets('categoryCard has a title', (WidgetTester tester) async {
     provideMockedNetworkImages(() async {
       await tester.pumpWidget(CategoryCard(category: category));
       final titleFinder = find.text(category.name);

       expect(titleFinder, findsOneWidget);
    });
  });
}