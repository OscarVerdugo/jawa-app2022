import '../models/product/inventory_product_model.dart';
import '../models/product/price_group_model.dart';
import '../models/product/product_model.dart';

export 'package:jawa_app/app/utils/connection.dart';
export 'package:jawa_app/app/utils/regex.dart';
export 'package:jawa_app/app/utils/validators.dart';

class Utils {
  static bool compareDates(DateTime d1, DateTime d2) {
    if (d1.year == d2.year && d1.month == d2.month && d1.day == d2.day) {
      return true;
    } else {
      return false;
    }
  }

  static void pairWithInventory(
      List<ProductModel> products, List<InventoryProductModel> inventory) {
    for (var p in products) {
      final i =
          inventory.indexWhere((i) => i.idPresentacion == p.idPresentacion);
      if (i != -1) {
        p.disponible = inventory[i].disponible;
      }
    }
  }

  static void pairWithPrices(
      {required List<ProductModel> products,
      required int idPriceGroup,
      required List<PriceGroupModel> groups}) {
    final group = groups.firstWhere((g) => g.idGrupoPrecio == idPriceGroup);
    for (var p in products) {
      final price =
          group.precios.firstWhere((p) => p.idPresentacion == p.idPresentacion);
      p.precio = price.precioUnitario;
    }
  }
}
