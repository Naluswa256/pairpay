import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizzle_starter/src/core/constant/sizeConfig/size_config.dart';
import 'package:badges/badges.dart' as badges;
import 'package:custom_rating_bar/custom_rating_bar.dart';

class LawyerCard extends StatelessWidget {
  final String lawyerNames;
  final String specialist;
  final String photo;
  final double rating; // Changed to double for the rating value
  final int reviewCount; // Changed to int for the number of reviews
  final bool isOnline;
  final bool isVerified;

  LawyerCard({
    Key? key,
    this.lawyerNames = "",
    this.specialist = "Civil Law",
    this.photo =
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnLnP_dX6SiNEaqhA_MiXBlUAZSWEXRvds-A&usqp=CAU",
    this.rating = 0.0, // Default value for rating
    this.reviewCount = 0, // Default value for review count
    this.isOnline = false,
    required this.isVerified
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MySize().init(context);

    return Container(
      margin: EdgeInsets.fromLTRB(
        MySize.getScaledSizeWidth(15),
        0,
        MySize.getScaledSizeWidth(15),
        MySize.getScaledSizeWidth(15),
      ),
      padding: EdgeInsets.fromLTRB(
        MySize.getScaledSizeWidth(20),
        MySize.getScaledSizeHeight(15),
        MySize.getScaledSizeWidth(20),
        0,
      ),
      width: MySize.getScaledSizeWidth(180),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.all(Radius.circular(MySize.getScaledSizeHeight(13))),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(18)),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                      MySize.getScaledSizeHeight(10000.0)),
                  child: CachedNetworkImage(
                    imageUrl: photo,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Image.asset(
                      "assets/images/placeholder.png",
                      fit: BoxFit.cover,
                      width: MySize.getScaledSizeHeight(72),
                      height: MySize.getScaledSizeHeight(72),
                    ),
                    width: MySize.getScaledSizeHeight(72),
                    height: MySize.getScaledSizeHeight(72),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                if (isOnline)
                  Positioned(
                    right: 1,
                    top: 3,
                    child: Container(
                      width: MySize.getScaledSizeWidth(16),
                      height: MySize.getScaledSizeHeight(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        color: Color(0xff3E64FF),
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
              ],
            ),
          ),
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: -3, end: -25),
            showBadge: isVerified,
            ignorePointer: false,
            onTap: () {},
            badgeContent: Icon(Icons.check, color: Colors.white, size: 10),
            badgeStyle: badges.BadgeStyle(
              shape: badges.BadgeShape.twitter,
              badgeColor: Colors.blue,
              padding: EdgeInsets.all(5),
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.white, width: 2),
              elevation: 0,
            ),
            child: Text(
              lawyerNames,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color(0xFF222B45),
                fontSize: 14,
                fontFamily: "Poppins-SemiBold",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MySize.getScaledSizeHeight(2)),
            child: Text(
              specialist,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: "Poppins-Bold",
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: MySize.getScaledSizeHeight(5)),
                  child: Center(
                    child: RatingBar(
                      filledIcon: Icons.star,
                      size: 20,
                      emptyIcon: Icons.star_border,
                      onRatingChanged: (value) => debugPrint('$value'),
                      initialRating: reviewCount.toDouble(),
                      maxRating: 5,
                    ),
                  )),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: MySize.getScaledSizeHeight(4)),
            child: Text(
              '$reviewCount reviews',
              style: TextStyle(
                color: Color(0xff6B779A),
                fontSize: MySize.getScaledSizeHeight(12),
                fontFamily: "Poppins-Regular",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
