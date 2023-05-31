import 'package:flutter/material.dart';
import 'package:pinterest_clone/utils/app_colours.dart';
import '../ui_screens/reusable_widgets/app_button.dart';
import 'material_dialogue_content.dart';

class MaterialDialogHelper {
  static MaterialDialogHelper? _instance;

  MaterialDialogHelper._();

  static MaterialDialogHelper instance() {
    _instance ??= MaterialDialogHelper._();
    return _instance!;
  }

  BuildContext? _context;

  void injectContext(BuildContext context) => _context = context;

  void dismissProgress() {
    final context = _context;
    if (context == null) return;
    Navigator.pop(context);
  }

  void showProgressDialog(String text) {
    final context = _context;
    if (context == null) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              child: Dialog(
                  backgroundColor: AppColours.colorPrimary,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 25, right: 25),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        const CircularProgressIndicator(
                            backgroundColor: AppColours.colorOnPrimary,
                            strokeWidth: 3),
                        const SizedBox(width: 10),
                        Flexible(
                            child: Text(text,
                                style: const TextStyle(
                                    color: AppColours.colorOnPrimary,
                                    fontFamily: AppFonts.helveticaBold,
                                    fontSize: 14)))
                      ]))),
              onWillPop: () async => false);
        });
  }

  void showMaterialDialogWithContent(
      MaterialDialogContent content, Function positiveClickListener,
      {Function? negativeClickListener}) {
    final context = _context;
    if (context == null) return;
    showDialog(
        context: context,
        builder: (_) {
          return WillPopScope(
              child: AlertDialog(
                  insetPadding: const EdgeInsets.symmetric(horizontal: 25),
                  contentPadding: const EdgeInsets.only(bottom: 0),
                  backgroundColor: AppColours.scaffoldColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  content: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColours.colorSecondary)),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(content.title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontFamily: AppFonts.helveticaBold,
                                        fontSize: 22,
                                        color: AppColours.colorOnSecondary))),
                            const SizedBox(height: 10),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(content.message,
                                    style: TextStyle(
                                        color: AppColours.colorOnSecondary
                                            .withOpacity(0.7),
                                        fontSize: 14,
                                        fontFamily:
                                        AppFonts.helveticaLight))),
                            const SizedBox(height: 20),
                            IntrinsicHeight(
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  SizedBox(
                                      height: 35,
                                      width: 100,
                                      child: AppButton(
                                          onClick: () => Navigator.pop(context),
                                          text: content.negativeText,
                                          fontFamily:
                                          AppFonts.helveticaLight,
                                          textColor: AppColours.colorPrimary,
                                          borderRadius: 10.0,
                                          fontSize: 16,
                                          color: AppColours.colorOnSurface
                                              .withOpacity(0.5))),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                      height: 35,
                                      width: 100,
                                      child: AppButton(
                                          onClick: () {
                                            Navigator.pop(context);
                                            positiveClickListener.call();
                                          },
                                          text: content.positiveText,
                                          fontFamily:
                                          AppFonts.helveticaLight,
                                          textColor: AppColours.colorOnSurface,
                                          borderRadius: 10.0,
                                          fontSize: 16,
                                          color: AppColours.colorPrimaryVariant))
                                ])),
                            const SizedBox(height: 25)
                          ]))),
              onWillPop: () async => false);
        });
  }
}
