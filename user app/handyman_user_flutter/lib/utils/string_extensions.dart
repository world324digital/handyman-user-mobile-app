import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/images.dart';
import 'package:flutter/material.dart';

extension strEtx on String {
  Widget iconImage({double? size, Color? color, BoxFit? fit}) {
    return Image.asset(
      this,
      height: size ?? 24,
      width: size ?? 24,
      fit: fit ?? BoxFit.cover,
      color: color ?? (appStore.isDarkMode ? Colors.white : appTextSecondaryColor),
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(ic_no_photo, height: size ?? 24, width: size ?? 24);
      },
    );
  }

  Color get getPaymentStatusBackgroundColor {
    switch (this) {
      case "pending":
        return pending;
      case "accept":
        return accept;
      case "on_going":
        return on_going;
      case "in_progress":
        return in_progress;
      case "hold":
        return hold;
      case "cancelled":
        return cancelled;
      case "rejected":
        return rejected;
      case "failed":
        return failed;
      case "completed":
        return completed;

      default:
        return defaultStatus;
    }
  }

  Color get getBookingActivityStatusColor {
    switch (this) {
      case "add_booking":
        return add_booking;
      case "assigned_booking":
        return assigned_booking;
      case "transfer_booking":
        return transfer_booking;
      case "update_booking_status":
        return update_booking_status;
      case "cancel_booking":
        return cancel_booking;
      case "payment_message_status":
        return payment_message_status;

      default:
        return defaultActivityStatus;
    }
  }

  Color get getJobStatusColor {
    switch (this) {
      case "pending":
        return pending;
      case "accept":
        return accept;
      case "on_going":
        return on_going;
      case "in_progress":
        return in_progress;
      case "hold":
        return hold;
      case "cancelled":
        return cancelled;
      case "rejected":
        return rejected;
      case "failed":
        return failed;
      case "completed":
        return completed;

      default:
        return defaultStatus;
    }
  }
}
