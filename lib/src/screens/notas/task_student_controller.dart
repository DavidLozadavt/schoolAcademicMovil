import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/providers/activity_provider.dart';
import 'package:vtschool/src/providers/notifications_provider.dart';

class TaskStudentController extends GetxController {
  final NotificationsProvider _notificationsProvider = NotificationsProvider();
final ActivityProvider _activityProvider = ActivityProvider();
  var isLoading = true.obs;
  var activities = <Map<String, dynamic>>[].obs;
  

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }
  
  Future<void> getNotifications() async {
    isLoading(true);
    try {
      await _notificationsProvider.getNotifications();
      activities.assignAll(_notificationsProvider.activities);
    } finally {
      isLoading(false);
    }
  }



}