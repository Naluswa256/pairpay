import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  final _carouselController = CarouselController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      ExpandableCarousel(
        options: CarouselOptions(
          autoPlay: true, // Set autoplay to true
          autoPlayInterval: const Duration(seconds: 2),
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: false,
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          pageSnapping: true,
          scrollDirection: Axis.horizontal,
          pauseAutoPlayOnTouch: true,
          pauseAutoPlayOnManualNavigate: true,
          pauseAutoPlayInFiniteScroll: false,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          disableCenter: false,
          showIndicator: false,
          onPageChanged: (index, reason) => setState(() => _currentPage = index), // Update current page on change
        ),
        items: [
          'https://images.quicket.co.za/0597453_0.jpeg',
          'https://images.quicket.co.za/0579513_0.jpeg',
          'https://images.quicket.co.za/0575046_0.jpeg',
          'https://images.quicket.co.za/0597453_0.jpeg',
          'https://images.quicket.co.za/0579513_0.jpeg',
          'https://images.quicket.co.za/0575046_0.jpeg',
        ].map((imageUrl) => Builder(
          builder: (BuildContext context) => Container(
            width: 30.w,
            height: 30.h,
            margin: EdgeInsets.symmetric(horizontal: 3.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ))
            .toList(),
      ),
      Positioned(
        bottom: 20.0,
        left: 0.0,
        right: 0.0,
        child: Center(
          child: DotsIndicator(
            dotsCount: 6,
            position: _currentPage, // Use _currentPage for sync
            decorator: DotsDecorator(
              activeColor: Colors.red,
              size: Size.square(5.0),
              activeSize: Size.square(8.0),
            ),
          ),
        ),
      ),
    ],
  );
}


