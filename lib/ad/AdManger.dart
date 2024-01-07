class AdManger {
  static bool isTest = false;

  static String bannerHome = isTest
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-8926855590765148/9002830421';

  static String interstitialAd = isTest
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-8926855590765148/4252175978';

  static String appOpenAd = isTest
      ? 'ca-app-pub-3940256099942544/9257395921'
      : 'ca-app-pub-8926855590765148/3804673160';
}
