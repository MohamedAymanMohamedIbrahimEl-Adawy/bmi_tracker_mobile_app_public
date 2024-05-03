import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../data/models/bmi/bmi_model.dart';
import '../../data/models/response/app_response.dart';
import '../../data/repositories/bmi/bmi_repo.dart';
import '../../main.dart';
import '../../services/snacks/app_snacks.dart';

class BmiProvider with ChangeNotifier {
  final BmiRepository _bmiRepository;

  BmiProvider({
    required BmiRepository bmiRepository,
  }) : _bmiRepository = bmiRepository;

  bool _isLoading = true;
  bool get getIsLoading => _isLoading;

  final List<BmiModel> _allRecords = [];

  List<BmiModel> get getRecords => [..._allRecords];

  Future<void> addRecord(BmiModel bmiModel) async {
    AppResponse appResponse = await _bmiRepository.add(bmiModel);
    if (appResponse.hasError) {
      AppSnacks.showTopSnackBar(
        context: Get.context!,
        title: 'alert'.tr(),
        body: appResponse.message ?? 'anErrorOccurred'.tr(),
        seconds: 2,
      );
    } else {
      //
      _allRecords.insert(0, bmiModel);
      AppSnacks.showTopSnackBar(
        context: Get.context!,
        title: 'nice'.tr(),
        body: 'recordIsAddedSuccessfully'.tr(),
        seconds: 2,
      );
    }
    notifyListeners();
  }

  Future<void> updateRecord(BmiModel bmiModel) async {
    AppResponse appResponse = await _bmiRepository.update(bmiModel);
    if (appResponse.hasError) {
      AppSnacks.showTopSnackBar(
        context: Get.context!,
        title: 'alert'.tr(),
        body: appResponse.message ?? 'anErrorOccurred'.tr(),
        seconds: 2,
      );
    } else {
      //
      int index =
          _allRecords.indexWhere((element) => element.id == bmiModel.id);
      _allRecords.removeAt(index);
      _allRecords.insert(
        index,
        bmiModel,
      );
      AppSnacks.showTopSnackBar(
        context: Get.context!,
        title: 'nice'.tr(),
        body: 'recordIsSavedSuccessfully'.tr(),
        seconds: 2,
      );
    }
    notifyListeners();
  }

  Future<void> deleteRecord(BmiModel bmiModel) async {
    AppResponse appResponse = await _bmiRepository.delete(bmiModel);
    if (appResponse.hasError) {
      AppSnacks.showTopSnackBar(
        context: Get.context!,
        title: 'alert'.tr(),
        body: appResponse.message ?? 'anErrorOccurred'.tr(),
        seconds: 2,
      );
    } else {
      //
      _allRecords.removeWhere((element) => element.id == bmiModel.id);
      AppSnacks.showTopSnackBar(
        context: Get.context!,
        title: 'nice'.tr(),
        body: 'recordIsDeletedSuccessfully'.tr(),
        seconds: 2,
      );
    }
    notifyListeners();
  }

  Future<void> deleteAll() async {
    AppSnacks.showTopSnackBar(
      context: Get.context!,
      title: 'waiting'.tr(),
      body: 'pleaseWait'.tr(),
      seconds: 2,
    );
    AppResponse appResponse = await _bmiRepository.deleteAll();
    if (appResponse.hasError) {
      AppSnacks.showTopSnackBar(
        context: Get.context!,
        title: 'alert'.tr(),
        body: appResponse.message ?? 'anErrorOccurred'.tr(),
        seconds: 2,
      );
    } else {
      //
      _allRecords.clear();
      AppSnacks.showTopSnackBar(
        context: Get.context!,
        title: 'nice'.tr(),
        body: 'allRecordsAreDeletedSuccessfully'.tr(),
        seconds: 2,
      );
    }
    notifyListeners();
  }

  Future<void> fetch(bool isLoadingMore) async {
    if (!isLoadingMore) {
      _isLoading = true;
      _allRecords.clear();
      notifyListeners();
    }
    log('Current limit = ${_allRecords.length} , New Limit = ${_allRecords.length + 10}');
    AppResponse appResponse =
        await _bmiRepository.fetch(_allRecords.length + 10);
    _isLoading = false;

    if (appResponse.hasError) {
      AppSnacks.showTopSnackBar(
        context: Get.context!,
        title: 'alert'.tr(),
        body: appResponse.message ?? 'anErrorOccurred'.tr(),
        seconds: 2,
      );
    } else {
      if (isLoadingMore) {
        final List<BmiModel> tempOutlist =
            appResponse.data!['data'] as List<BmiModel>;
        tempOutlist.removeRange(0, _allRecords.length);

        log('New records length = ${tempOutlist.length}');
        _allRecords.addAll(tempOutlist);
        log('All records length = ${_allRecords.length}');
      } else {
        // This is in case fetching the records for the first time
        _allRecords.addAll(
          appResponse.data!['data'] as List<BmiModel>,
        );
      }
    }
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }
}
