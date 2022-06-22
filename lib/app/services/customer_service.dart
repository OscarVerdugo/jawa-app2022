import 'package:jawa_app/app/models/http/data_model.dart';
import 'package:jawa_app/app/models/route/customer_view_model.dart';

import '../models/http/res_model.dart';
import 'http_service.dart';

class CustomerService {
  Future<HttpResponsePagination<List<CustomerViewModel>>> getCustomers(
      {required Pagination pagination}) async {
    try {
      HttpResponsePagination<List<CustomerViewModel>> response =
          await HttpService.postPagination<List<CustomerViewModel>>(
              method: "clientes/obtenerclientesvista",
              dataOrigin: "lst",
              pagination: pagination,
              data: {});
      if (response.rawData != null) {
        response.data = List<CustomerViewModel>.from(
            response.rawData.map((x) => CustomerViewModel.fromMap(x)));
      }
      return response;
    } catch (e) {
      return HttpResponsePagination.fromError(e.toString(), 0);
    }
  }
}
