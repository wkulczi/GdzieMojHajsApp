import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:gdziemojhajsapp/categoryCard.dart';
import 'package:gdziemojhajsapp/Category.dart';

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