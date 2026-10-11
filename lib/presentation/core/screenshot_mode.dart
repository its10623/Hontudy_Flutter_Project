/// 스토어 스크린샷 촬영용: flutter run --dart-define=SCREENSHOT=true
/// 디버그 빌드에서도 DEBUG 띠와 디버그 전용 UI를 숨김
const kScreenshotMode = bool.fromEnvironment('SCREENSHOT');
