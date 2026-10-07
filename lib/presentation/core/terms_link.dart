import 'package:url_launcher/url_launcher.dart';

const termsUrl =
    'https://rhinestone-rib-c44.notion.site/3f17027c4882806bb21be1ea2736514e';

Future<void> openTermsPage() => launchUrl(
  Uri.parse(termsUrl),
  mode: LaunchMode.externalApplication,
);
