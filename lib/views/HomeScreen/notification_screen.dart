// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:astrowaypartner/constants/colorConst.dart';
import 'package:astrowaypartner/controllers/notification_controller.dart';
import 'package:astrowaypartner/widgets/app_bar_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/messageConst.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  NotificationController notificationController =
      Get.find<NotificationController>();
  Color getRandomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
        .withOpacity(1.0);
  }

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLORS().greyBackgroundColor,
        appBar: MyCustomAppBar(
          height: 80,
          backgroundColor: COLORS().primaryColor,
          title: Text(
            "Notification",
            style: TextStyle(fontSize: 16.sp),
          ).tr(),
          actions: [
            IconButton(
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    titleTextStyle: Get.textTheme.bodyLarge,
                    title: const Text(
                            "Are you sure you want delete all notifications?")
                        .tr(),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(MessageConstants.No).tr(),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            Get.back(); //back from dialog
                            await notificationController
                                .deleteAllNotification();
                          },
                          child: const Text(MessageConstants.YES).tr(),
                        ),
                      ],
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
        body: GetBuilder<NotificationController>(
          builder: (notificationController) {
            return SizedBox(
              height: height,
              width: width,
              child: notificationController.notificationList.isEmpty
                  ? Center(child: const Text('No Notification is here').tr())
                  : ListView.builder(
                      itemCount: notificationController.notificationList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 1,
                          margin: const EdgeInsets.all(5),
                          child: ListTile(
                            tileColor: notificationController
                                            .notificationList[index]
                                            .callStatus ==
                                        'Rejected' ||
                                    notificationController
                                            .notificationList[index]
                                            .chatStatus ==
                                        'Rejected' ||
                                    notificationController
                                            .notificationList[index]
                                            .callStatus ==
                                        'Accepted' ||
                                    notificationController
                                            .notificationList[index]
                                            .chatStatus ==
                                        'Accepted'
                                ? Colors.grey.shade300
                                : Colors.white,
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 3.h,
                                  backgroundColor: getRandomColor(),
                                  child: Center(
                                    child: Text('$index',
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notificationController
                                      .notificationList[index].title!,
                                  style:
                                      Get.theme.primaryTextTheme.displaySmall,
                                ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: Text(
                                notificationController
                                    .notificationList[index].description!,
                                style: TextStyle(fontSize: 10.sp),
                              ),
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.dialog(
                                      AlertDialog(
                                        titleTextStyle: Get.textTheme.bodyLarge,
                                        title: const Text(
                                                "Are you sure you want delete notification?")
                                            .tr(),
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Text(
                                                      MessageConstants.No)
                                                  .tr(),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                Get.back(); //back from dialog
                                                await notificationController
                                                    .deleteNotification(
                                                        notificationController
                                                            .notificationList[
                                                                index]
                                                            .id!);
                                              },
                                              child: const Text(
                                                      MessageConstants.YES)
                                                  .tr(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    size: 22,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  DateFormat('dd/MM/yy').format(DateTime.parse(
                                      notificationController
                                          .notificationList[index].createdAt
                                          .toString())),
                                  style: TextStyle(fontSize: 8.sp),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            );
          },
        ),
      ),
    );
  }
}
