// ignore_for_file: inference_failure_on_instance_creation

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/request_appointement.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/widgets/badge_lawyer.dart';
import 'package:sizzle_starter/src/feature/app/model/user_model.dart';
import 'package:badges/badges.dart' as badges;
import 'package:timeago/timeago.dart' as timeago;

class LawyerDetailScreen extends StatefulWidget {
  final User lawyerModel;
  const LawyerDetailScreen({required this.lawyerModel, super.key});

  @override
  _LawyerDetailScreenState createState() => _LawyerDetailScreenState();
}

class _LawyerDetailScreenState extends State<LawyerDetailScreen> {
  bool _isExpanded = false;
  final bool? onlineStatus = null;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                decoration: const BoxDecoration(color: Color(0xffFAFAFC)),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                        color: const Color(0xff222B45),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                decoration: const BoxDecoration(
                  color: Color(0xffFAFAFC),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10000.0),
                              child: CachedNetworkImage(
                                imageUrl: widget.lawyerModel.avatar,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Image.asset(
                                  "assets/images/placeholder.png",
                                  fit: BoxFit.cover,
                                  width: 110,
                                  height: 110,
                                ),
                                width: 110,
                                height: 110,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              )),
                          if (onlineStatus != null)
                            Positioned(
                              top: 1,
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(70, 3, 0, 0),
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    color: const Color(0xff3E64FF),
                                    shape: BoxShape.circle),
                              ),
                            )
                          else
                            Container(
                              width: 0,
                              height: 0,
                            )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 3),
                      alignment: Alignment.center,
                      child: badges.Badge(
                        position:
                            badges.BadgePosition.topEnd(top: -3, end: -25),
                        showBadge: widget.lawyerModel.isVerified,
                        ignorePointer: false,
                        onTap: () {},
                        badgeContent: const Icon(Icons.check,
                            color: Colors.white, size: 10),
                        badgeStyle: badges.BadgeStyle(
                          shape: badges.BadgeShape.twitter,
                          badgeColor: Colors.blue,
                          padding: const EdgeInsets.all(5),
                          borderRadius: BorderRadius.circular(4),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2),
                          elevation: 0,
                        ),
                        child: Text(
                          widget.lawyerModel.fullNames,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF222B45),
                            fontSize: 20,
                            fontFamily: "Poppins-SemiBold",
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Lawyer Specialization',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xff6B779A),
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 27, 0, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BadgeLawyer(
                            color: 0xff7ACEFA,
                            icon: EvaIcons.peopleOutline,
                            label: "Consultations",
                            value: widget.lawyerModel.appointments.length
                                .toString(),
                          ),
                          BadgeLawyer(
                              color: 0xffE8899E,
                              icon: EvaIcons.awardOutline,
                              label: "Experience",
                              value: widget.lawyerModel.yearsOfExperience
                                  .toString()),
                          BadgeLawyer(
                            color: 0xffF7C480,
                            icon: EvaIcons.starOutline,
                            label: "Ratings",
                            value: widget.lawyerModel.averageRating.toString(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(25, 30, 25, 0),
                alignment: Alignment.topLeft,
                child: const Text(
                  "About Lawyer",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xff222B45),
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                alignment: Alignment.centerLeft,
                child: ReadMoreText(
                  widget.lawyerModel.about,
                  trimLines: 2,
                  colorClickableText: Colors.blue,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  style: const TextStyle(
                    color: Color(0xff6B779A),
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(25, 30, 25, 0),
                alignment: Alignment.topLeft,
                child: const Text(
                  "Employment History",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xff222B45),
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      widget.lawyerModel.employmentHistory.map((employment) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            employment.jobTitle,
                            style: const TextStyle(
                              color: Color(0xff222B45),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            employment.companyName,
                            style: const TextStyle(
                              color: Color(0xff6B779A),
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${employment.startMonth} ${employment.startYear} - ${employment.isCurrent ? 'Present' : '${employment.endMonth} ${employment.endYear}'}",
                            style: const TextStyle(
                              color: Color(0xff6B779A),
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          if (employment.description.isNotEmpty)
                            Text(
                              employment.description,
                              style: const TextStyle(
                                color: Color(0xff6B779A),
                                fontSize: 15,
                              ),
                            ),
                        ]);
                  }).toList(),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(25, 30, 25, 0),
                alignment: Alignment.topLeft,
                child: const Text(
                  "Education",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xff222B45),
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.lawyerModel.education.map((education) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            education.degree,
                            style: const TextStyle(
                              color: Color(0xff222B45),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            education.institutionName,
                            style: const TextStyle(
                              color: Color(0xff6B779A),
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${education.startYear} - ${education.currentlyAttending ? 'Present' : education.endYear}",
                            style: const TextStyle(
                              color: Color(0xff6B779A),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                alignment: Alignment.topLeft,
                child: const Text(
                  "Working time",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xff222B45),
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.lawyerModel.availableSlots.map((slot) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${slot.day} - ",
                          style: const TextStyle(
                            color: Color(0xff222B45),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          // Wrap with Expanded to ensure text wraps if too long
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: slot.timeSlots
                                .map(
                                  (timeSlot) => Text(
                                    "Available from ${timeSlot.startTime} to ${timeSlot.endTime}",
                                    style: const TextStyle(
                                      color: Color(0xff6B779A),
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              if (widget.lawyerModel.reviewsReceived.isNotEmpty)
                Container(
                  margin: const EdgeInsets.fromLTRB(25, 30, 25, 0),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Reviews",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xff222B45),
                      fontSize: 18,
                    ),
                  ),
                ),
              if (widget.lawyerModel.reviewsReceived.isNotEmpty)
                Container(
                  margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                  alignment: Alignment.center,
                  child: Column(
                    children: widget.lawyerModel.reviewsReceived.map((review) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      review.user.avatar),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      review.user.fullNames,
                                      style: const TextStyle(
                                        color: Color(0xff222B45),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      timeago.format(review.createdAt,
                                          locale: 'en_short'),
                                      style: const TextStyle(
                                        color: Color(0xff6B779A),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: List.generate(
                                      5,
                                      (index) => Icon(
                                            index < review.rating
                                                ? EvaIcons.star
                                                : EvaIcons.starOutline,
                                            color: Colors.yellow,
                                            size: 20,
                                          )),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ReadMoreText(
                              review.comment,
                              trimLines: 2,
                              colorClickableText: Colors.blue,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Show more',
                              trimExpandedText: 'Show less',
                              style: const TextStyle(
                                color: Color(0xff6B779A),
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              Container(
                margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff3E64FF),
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => AppointementsPage(lawyerId:widget.lawyerModel.id),
                      ),
                    );
                  },
                  child: const Text(
                    'Book an Appointment',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
