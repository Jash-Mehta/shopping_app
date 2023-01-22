import 'package:hive/hive.dart';

part 'cartmodel.g.dart';

@HiveType(typeId: 0)
class Cartmode extends HiveObject {
  @HiveField(0)
 late String title;
  @HiveField(1)
  var price;
  @HiveField(2)
  late String image;
  @HiveField(3)
  late var rating;
}
