import 'package:flutter/material.dart';
import 'package:task_flutter/core/localization/localization_helper.dart';

import '../../core/utils/extentions.dart';
import 'button_widget.dart';

class LoadingAndError extends StatelessWidget {
  const LoadingAndError({
    Key? key,
    required this.isError,
    required this.isLoading,
    this.function,
    required this.child,
  }) : super(key: key);
  final bool isError;
  final bool isLoading;
  final Widget child;
  final Function? function;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (isError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocalizationHelper.tr.dataError,
                  style: TextStyle(
                    fontSize: 18,
                    color: context.theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 24),
                if (Navigator.canPop(context) || function != null)
                  ButtonWidget(
                    // radius: 20,
                    withBorder: true,
                    width: 150,
                    height: 50,
                    // borderColor: Color(0xffDAF1DE),
                    // buttonColor: Color(0xffDAF1DE),
                    onTap: () async {
                      function != null
                          ? await function!()
                          : Navigator.canPop(context)
                          ? Navigator.pop(context)
                          : null;
                      // Navigator.pop(context);
                    },
                    child: Text(
                      function != null
                          ? LocalizationHelper.tr.retry
                          : LocalizationHelper.tr.goBack,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          );
        } else if (isLoading) {
          return Material(
            color: context.colorScheme.background,
            child: const Center(child: CircularProgressIndicator()),
          );
        } else {
          return child;
        }
      },
    );
  }
}
