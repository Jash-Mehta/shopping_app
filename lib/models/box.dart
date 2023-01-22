
import 'package:hive/hive.dart';
import 'package:shopping_app/models/cartmodel.dart';

class Boxes {
  

static Box<Cartmode> getTransactions() => Hive.box<Cartmode>('cartdetail');
}
