
import 'package:flutter/material.dart';


@immutable
abstract class DashboardStatus {}

class DashboardStatusInit extends DashboardStatus {}

class DashboardStatusLoading extends DashboardStatus {}

class DashboardStatusError extends DashboardStatus {
  final String errorMsg;
  DashboardStatusError(this.errorMsg);
}

class DashboardStatusCompleted extends DashboardStatus {
  final Map<String, dynamic> data;
  DashboardStatusCompleted(this.data);
}