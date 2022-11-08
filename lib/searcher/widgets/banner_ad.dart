import 'package:google_mobile_ads/google_mobile_ads.dart';

BannerAd myBanner(String adUnitId) {
  return BannerAd(
    adUnitId: adUnitId,
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );
}
