import 'package:flutter/material.dart';

class TimeUtils {
  /// Get greeting message based on current time
  static String getGreeting() {
    final hour = DateTime.now().hour;
    
    if (hour < 12) {
      return 'Good Morning! 🌅';
    } else if (hour < 17) {
      return 'Good Afternoon! ☀️';
    } else if (hour < 21) {
      return 'Good Evening! 🌅';
    } else {
      return 'Good Night! 🌙';
    }
  }
  
  /// Get greeting emoji based on current time
  static String getGreetingEmoji() {
    final hour = DateTime.now().hour;
    
    if (hour < 12) {
      return '🌅';
    } else if (hour < 17) {
      return '☀️';
    } else if (hour < 21) {
      return '🌆';
    } else {
      return '🌙';
    }
  }
  
  /// Format time to readable string
  static String formatTime(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour == 0 ? 12 : hour;
    
    return '$displayHour:$minute $period';
  }
  
  /// Format date to readable string
  static String formatDate(DateTime dateTime) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    
    return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}';
  }
}
