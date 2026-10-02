import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';
import 'package:hontudy/presentation/views/component/divider_widget.dart';
import 'package:hontudy/presentation/views/component/genui/gen_ui_box.dart';
import 'package:hontudy/presentation/views/component/primary_button.dart';

import 'full_screen_image.dart';

class ImageWidget extends StatelessWidget {
  final dynamic data;

  const ImageWidget({
    super.key,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    final caption = data['caption'].toString();
    return GenUiBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                caption,
                style: TextType.captionSmall.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const DividerWidget(),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/test.png', // 추후 네트워크 URL 이미지로 변경
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          PrimaryButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const FullScreenImagePage(assetImage: 'assets/test.png'),
                ),
              );
            },
            text: '이미지 크게보기',
            color: ButtonColor.primary,
          ),
        ],
      ),
    );
  }
}
