import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jawa_app/app/models/http/data_model.dart';
import 'package:jawa_app/app/models/route/customer_view_model.dart';

import '../../../controllers/global_controller.dart';
import '../../../services/customer_service.dart';
import '../../../utils/utils.dart';

class RouteAddCustomerController extends GetxController {
  final globalController = Get.find<GlobalController>();
  final customerService = CustomerService();

  final searchController = TextEditingController(text: null);
  final scrollController = ScrollController();

  final pagination = Pagination.init();

  final customers = RxList<CustomerViewModel>();

  final hasConnection = RxBool(false);
  final loading = RxBool(false);
  final searchLoading = RxBool(false);
  var searchable = true;

  Timer? _debounce;

  @override
  void onInit() async {
    super.onInit();
    Connection connection = Connection.getInstance();
    connection.onConnectionChange.listen(onChangeConnection);
    hasConnection.value = await connection.checkConnection();

    loadCustomers();

    scrollController.addListener(handleScroll);
  }

  loadCustomers({bool nextPage = false}) async {
    if (!nextPage) {
      loading.value = true;
      update();
    }
    if (hasConnection.value) {
      final res = await customerService.getCustomers(pagination: pagination);
      if (res.success && res.data != null) {
        if (!nextPage) {
          customers.value = res.data!;
        } else {
          customers.addAll(res.data!);
        }
      } else {
        print("RESULT FAILURE");
      }
    } else {}
    if (!nextPage) {
      loading.value = false;
    }
    update();
  }

  nextPage() async {
    print("search");
    searchable = false;
    searchLoading.value = true;
    update();
    pagination.page += 1;
    await loadCustomers(nextPage: true);
    searchLoading.value = false;
    update();

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      searchable = true;
    });
  }

  void onChangeConnection(bool hasConnection) {
    this.hasConnection.value = hasConnection;
    if (!hasConnection) {
      // displayMessage.value = true;
      // message.value = "Necesitas conexión a internet para iniciar";
    } else {
      // displayMessage.value = false;
      // message.value = null;
    }
  }

  void handleScroll() {
    scrollController.addListener(() {
      final trigger = 0.9 * scrollController.position.maxScrollExtent;

      if (scrollController.position.pixels > trigger && searchable) {
        nextPage();
      }
    });
  }

  @override
  void onClose() {
    _debounce?.cancel();
    scrollController.removeListener(handleScroll);
  }
}
