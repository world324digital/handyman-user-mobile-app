import 'package:booking_system_flutter/component/cached_image_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/screens/notification/notification_screen.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/images.dart';
import 'package:booking_system_flutter/utils/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class UserInfoComponent extends StatefulWidget {
  final int? notificationReadCount;

  UserInfoComponent({this.notificationReadCount});

  @override
  _UserInfoComponentState createState() => _UserInfoComponentState();
}

class _UserInfoComponentState extends State<UserInfoComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appStore.isDarkMode ? context.cardColor : context.primaryColor.withOpacity(0.25),
      child: Row(
        children: [
          Container(
            decoration: boxDecorationDefault(
              border: Border.all(color: context.primaryColor, width: 2),
              shape: BoxShape.circle,
            ),
            child: Container(
              decoration: boxDecorationDefault(
                border: Border.all(color: context.scaffoldBackgroundColor, width: 3),
                shape: BoxShape.circle,
              ),
              child: CachedImageWidget(
                url: appStore.userProfileImage.validate(),
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                radius: 60,
              ),
            ),
          ),
          8.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello, ${appStore.userFullName}', style: boldTextStyle(size: 18), maxLines: 1, overflow: TextOverflow.ellipsis),
              Text('${getWishes()}', style: boldTextStyle()),
            ],
          ).expand(),
          if (appStore.isLoggedIn)
            Container(
              decoration: boxDecorationDefault(color: appStore.isDarkMode ? context.scaffoldBackgroundColor : context.cardColor, shape: BoxShape.circle),
              height: 36,
              padding: EdgeInsets.all(8),
              width: 36,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ic_notification.iconImage(size: 24, color: context.primaryColor).center(),
                  Positioned(
                    top: -16,
                    right: -10,
                    child: widget.notificationReadCount.validate() > 0
                        ? Container(
                            padding: EdgeInsets.all(4),
                            child: FittedBox(
                              child: Text(widget.notificationReadCount.validate().toString(), style: primaryTextStyle(size: 12, color: Colors.white)),
                            ),
                            decoration: boxDecorationDefault(color: Colors.red, shape: BoxShape.circle),
                          )
                        : Offstage(),
                  )
                ],
              ),
            ).onTap(() {
              NotificationScreen().launch(context);
            })
        ],
      ).paddingOnly(top: context.statusBarHeight, left: 16, right: 16, bottom: 8),
    );
  }
}
