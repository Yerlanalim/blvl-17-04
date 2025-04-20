import 'package:flutter/material.dart';
import '../../../../domain/models/subscription_plan.dart';
import '../../../../domain/models/payment_record.dart';

class SubscriptionScreenController extends ChangeNotifier {
  SubscriptionPlan? selectedPlan;
  String? selectedPaymentMethod;
  String? promoCode;
  bool isProcessing = false;
  String? errorMessage;

  void selectPlan(SubscriptionPlan plan) {
    selectedPlan = plan;
    notifyListeners();
  }

  void selectPaymentMethod(String method) {
    selectedPaymentMethod = method;
    notifyListeners();
  }

  void setPromoCode(String code) {
    promoCode = code;
    notifyListeners();
  }

  void setProcessing(bool value) {
    isProcessing = value;
    notifyListeners();
  }

  void setError(String? error) {
    errorMessage = error;
    notifyListeners();
  }

  void reset() {
    selectedPlan = null;
    selectedPaymentMethod = null;
    promoCode = null;
    isProcessing = false;
    errorMessage = null;
    notifyListeners();
  }
}
