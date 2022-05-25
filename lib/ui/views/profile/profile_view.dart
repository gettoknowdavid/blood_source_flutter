import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/models/gender.dart';
import 'package:blood_source/ui/shared/widgets/profile/avatar.dart';
import 'package:blood_source/ui/shared/widgets/profile/blood_group_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './profile_view_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (model) async => await model.init(),
      builder: (context, model, Widget? child) {
        if (model.isBusy) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                CustomPaint(
                  child: SizedBox(height: 1.sh, width: 1.sw),
                  painter: ProfileHeaderPainter(),
                ),
                SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        100.verticalSpace,
                        const Avatar(),
                        10.verticalSpace,
                        Text(
                          model.data!.name!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        2.verticalSpace,
                        Text(
                          model.data!.email!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontStyle: FontStyle.italic,
                            color: Colors.black54,
                          ),
                        ),
                        2.verticalSpace,
                        model.data!.phone == null
                            ? const SizedBox()
                            : Text(
                                model.data!.phone!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black54,
                                ),
                              ),
                        20.verticalSpace,
                        const BloodGroupWidget(),
                        40.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    '20',
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Donations',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            100.horizontalSpace,
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Requests',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        40.verticalSpace,
                        ListView(
                          shrinkWrap: true,
                          primary: false,
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 32).r,
                          children: [
                            Title(
                              color: Colors.black,
                              child: Text(
                                'Other Details',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            ProfileDetailsItem(
                              icon: ImageIcon(
                                const AssetImage('assets/images/gender.png'),
                                size: 24.sp,
                              ),
                              title: 'Gender',
                              value: Gender
                                  .values[model.data!.gender!.index].value,
                            ),
                            ProfileDetailsItem(
                              icon: ImageIcon(
                                const AssetImage('assets/images/age.png'),
                                size: 24.sp,
                              ),
                              title: 'Age',
                              value: model.data!.age.toString(),
                            ),
                            ProfileDetailsItem(
                              icon: ImageIcon(
                                const AssetImage('assets/images/height.png'),
                                size: 24.sp,
                              ),
                              title: 'Height',
                              value: model.data!.height.toString(),
                            ),
                            ProfileDetailsItem(
                              icon: ImageIcon(
                                const AssetImage('assets/images/weight.png'),
                                size: 24.sp,
                              ),
                              title: 'Weight',
                              value: model.data!.weight.toString(),
                              showSeparator: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 46.h,
                        width: 46.h,
                        decoration: const BoxDecoration(
                          color: AppColors.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            print(model.data!.name);
                          },
                          color: Colors.white,
                          padding: EdgeInsets.all(1.r),
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                      Container(
                        height: 46.h,
                        width: 46.h,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () => model.signOut(),
                          color: Colors.red,
                          padding: EdgeInsets.all(1.r),
                          icon: const Icon(Icons.power_settings_new_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class ProfileHeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = AppColors.primary;
    Path path = Path()
      ..relativeLineTo(0.w, 120.w)
      ..quadraticBezierTo(size.width / 2, 220.w, size.width, 120.w)
      ..relativeLineTo(0.w, -120.w)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ProfileDetailsItem extends StatelessWidget {
  const ProfileDetailsItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
    this.showSeparator = true,
  }) : super(key: key);
  final Widget icon;
  final String title;
  final String? value;
  final bool showSeparator;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      leading: icon,
      title: Text(title, style: TextStyle(fontSize: 16.sp)),
      trailing: Text(value == null ? 'Not set yet' : value!,
          style: TextStyle(fontSize: 14.sp)),
      shape: Border(
        bottom: BorderSide(
          width: showSeparator ? 0.5.r : 0,
          color: showSeparator ? Colors.black26 : Colors.transparent,
        ),
      ),
    );
  }
}
