import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/ui/shared/widgets/app_text_button.dart';
import 'package:blood_source/utils/dialog_type.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void setupDialogUi() {
  final DialogService _dialogService = locator<DialogService>();

  final builders = {
    DialogType.basic: (context, sheetRequest, completer) => _BasicDialog(
          request: sheetRequest,
          completer: completer,
        ),
    DialogType.mailApps: (context, sheetRequest, completer) => _MailAppsDialog(
          request: sheetRequest,
          completer: completer,
        ),
    DialogType.loading: (context, sheetRequest, completer) =>
        const _LoadingDialog(),
  };

  _dialogService.registerCustomDialogBuilders(builders);
}

class _BasicDialog extends StatelessWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;
  const _BasicDialog({Key? key, this.request, this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog();
  }
}

class _MailAppsDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _MailAppsDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        child: Column(
          children: [
            request.title == null
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(bottom: 4).r,
                    child: Text(
                      request.title!,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
            request.description == null
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(bottom: 12).r,
                    child: Text(
                      request.description!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
            20.verticalSpace,
            request.data,
            const Spacer(),
            request.mainButtonTitle == null
                ? const SizedBox()
                : AppTextButton(
                    onTap: () => Navigator.pop(context),
                    text: request.mainButtonTitle!,
                    color: AppColors.swatch.shade700,
                  ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12).r,
        height: 0.35.sh,
        width: 1.sw,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.15),
              offset: Offset(0.r, 16.r),
              blurRadius: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingDialog extends StatelessWidget {
  const _LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Center(
        child: Container(
          child: const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
          padding: const EdgeInsets.all(24).r,
          height: 0.2.sw,
          width: 0.2.sw,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.1),
                offset: Offset(0.r, 16.r),
                blurRadius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
