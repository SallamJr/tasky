import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/helper.dart';
import '../../../../core/widgets/custom_cached_network_image.dart';
import '../../../../core/widgets/custom_clickable_detector.dart';
import '../../data/models/message_model.dart';

class CustomMessageItem extends StatelessWidget {
  const CustomMessageItem({
    Key? key,
    required this.message,
    required this.isSender,
  }) : super(key: key);

  final MessageModel message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      decoration: BoxDecoration(
        color: message.messageType == MessageType.image
            ? AppColors.transparent
            : isSender
                ? AppColors.grey.withOpacity(0.4)
                : AppColors.secondary,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            Constants.borderRadius,
          ),
        ).copyWith(
          topLeft: isSender
              ? const Radius.circular(Constants.borderRadius)
              : Radius.zero,
          topRight: isSender
              ? Radius.zero
              : const Radius.circular(Constants.borderRadius),
        ),
      ),
      padding: message.messageType == MessageType.image
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(
              horizontal: Constants.defaultPadding,
              vertical: Constants.defaultPadding / 2,
            ),
      margin: const EdgeInsets.only(
        bottom: Constants.defaultPadding / 2,
      ),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          message.messageType == MessageType.image
              ? CustomClickableDetector(
                  onPressed: () {
                    Helper.showBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: PhotoView(
                              imageProvider: NetworkImage(
                                message.message,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: Constants.defaultPadding / 5,
                    ),
                    child: CustomCachedNetworkImage(
                      width: 160,
                      height: 160,
                      url: message.message,
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              : Text(
                  message.message,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
          Text(
            timeago.format(
              message.createdAt,
            ),
            softWrap: true,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
