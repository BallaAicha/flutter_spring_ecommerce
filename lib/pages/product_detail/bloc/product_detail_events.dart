import 'package:e_commerce/common/entities/ProductResponse.dart';

abstract class ProductDetailEvents {
  const ProductDetailEvents();
}

class TriggerProductDetail extends ProductDetailEvents {
  const TriggerProductDetail(this.productResponse) : super();
  final ProductResponse productResponse;
}

// class TriggerLessonList extends CourseDetailEvents{
//   const TriggerLessonList(this.lessonItem):super();
//   final List<LessonItem> lessonItem;
// }

// class TriggerCheckBuy extends CourseDetailEvents{
//   const TriggerCheckBuy(this.checkBuy):super();
//   final bool checkBuy;
// }
