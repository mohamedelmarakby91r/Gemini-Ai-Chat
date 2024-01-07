import 'package:geminiaichat/ad/AdManger.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Ads {
  InterstitialAd? _interstitialAd;
  AppOpenAd? _appOpenAd;
  void showAd() {
    InterstitialAd.load(
        adUnitId: AdManger.interstitialAd,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            _interstitialAd = ad;
            if (_interstitialAd != null) {
              _interstitialAd!.show();
            }
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdWillDismissFullScreenContent: (ad) {
                ad.dispose();
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose();
              },
            );
          },
          onAdFailedToLoad: (error) {
            print(error);
          },
        ));
  }

  void showAppOpedAd() {
    AppOpenAd.load(
        adUnitId: AdManger.appOpenAd,
        request: AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) {
            _appOpenAd = ad;
            if (_appOpenAd != null) {
              _appOpenAd!.show();
            }
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdWillDismissFullScreenContent: (ad) {
                ad.dispose();
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose();
              },
            );
          },
          onAdFailedToLoad: (error) {},
        ),
        orientation: AppOpenAd.orientationPortrait);
  }
}
