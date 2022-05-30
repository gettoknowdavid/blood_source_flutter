import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blood_source/models/blood_group.dart';

class RequestListItem extends StatelessWidget {
  const RequestListItem({Key? key, required this.request}) : super(key: key);

  final Request request;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 18.r, vertical: 12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            spreadRadius: 0,
            color: Colors.black12,
            offset: Offset(0, 10.h),
          )
        ],
      ),
      child: ListTile(
        title: Text(request.bloodGroup.value.desc),
        isThreeLine: true,
        leading: CircleAvatar(
          radius: 25.w,
          backgroundColor: AppColors.swatch.shade400,
          foregroundImage: NetworkImage(request.user.avatar),
        ),
        subtitle: Text(
          dateFormatter(request.timeAdded!.toIso8601String()),
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(7.r),
          decoration: BoxDecoration(
            color: request.requestGranted ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            request.requestGranted ? 'GRANTED' : 'PENDING',
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
