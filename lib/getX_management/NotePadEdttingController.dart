import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotePadEditingController extends GetxController {

  void makeSelectedTextBold(TextEditingController controller,TextSelection selection ) {
    String fullText = controller.text;
    int start = selection.start;
    int end = selection.end;

    if (start < 0 || end <= start) return; // No text selected

    String selectedText = fullText.substring(start, end);
    String newText =
        "${fullText.substring(0, start)}**$selectedText**${fullText.substring(end)}";

    controller.text = newText;
    controller.selection = TextSelection.collapsed(offset: newText.length);

    update(); // Notify UI about changes
  }
}