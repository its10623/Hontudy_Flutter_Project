import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/views/component/primary_button.dart';

import 'full_screen_image.dart';

class ImageWidget extends StatefulWidget {
  final String url;

  const ImageWidget({
    super.key,
    required this.url,
  });

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  /// 같은 인스턴스를 전체 화면에도 넘겨 이미지 캐시를 같이 쓰게함
  ImageProvider? _image;

  @override
  void initState() {
    super.initState();
    _image = imageProviderFrom(widget.url);
  }

  @override
  void didUpdateWidget(covariant ImageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _image = imageProviderFrom(widget.url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final image = _image;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: image == null
                  ? const _ImageFallback()
                  : Image(
                      image: image,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, progress) =>
                          progress == null ? child : const _ImageLoading(),
                      errorBuilder: (context, error, stackTrace) =>
                          const _ImageFallback(),
                    ),
            ),
          ),
          if (image != null) ...[
            const SizedBox(height: 8),
            PrimaryButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenImagePage(image: image),
                ),
              ),
              text: '이미지 크게보기',
              color: ButtonColor.primary,
            ),
          ],
        ],
      ),
    );
  }
}


ImageProvider? imageProviderFrom(String source) {
  if (!source.startsWith('data:')) return NetworkImage(source);
  try {
    final data = UriData.parse(source);
    return MemoryImage(data.contentAsBytes());
  } on FormatException {
    return null;
  }
}

class _ImageLoading extends StatelessWidget {
  const _ImageLoading();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.surfaceContainer,
      child: Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: context.colors.outline,
          ),
        ),
      ),
    );
  }
}

class _ImageFallback extends StatelessWidget {
  const _ImageFallback();

  @override
  Widget build(BuildContext context) {
    final color = context.colors.outline;
    return ColoredBox(
      color: context.colors.surfaceContainer,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.broken_image_outlined, color: color),
            const SizedBox(height: 6),
            Text(
              '이미지를 불러오지 못했어요',
              style: context.captionMedium.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
