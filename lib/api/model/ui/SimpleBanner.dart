class SimpleBanner {
  final String image;
  final String youtube;

  SimpleBanner(this.image, {this.youtube = ""});
}

class SimpleBanners {
  final id;
  final List<SimpleBanner> banners;

  SimpleBanners(this.id, this.banners);
}
