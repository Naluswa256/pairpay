import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/widgets/badge_lawyer.dart';
import 'package:sizzle_starter/src/feature/app/model/user_model.dart';

class Review {
  final String avatar;
  final String clientName;
  final String description;
  final double rating;
  final String date;

  Review({
    required this.avatar,
    required this.clientName,
    required this.description,
    required this.rating,
    required this.date,
  });
}

class LawyerDetailScreen extends StatefulWidget {
  final User lawyerModel;
  const LawyerDetailScreen({required this.lawyerModel, super.key});

  @override
  _LawyerDetailScreenState createState() => _LawyerDetailScreenState();
}

class _LawyerDetailScreenState extends State<LawyerDetailScreen> {
  bool _isExpanded = false;
  final bool? onlineStatus = null;
  List<Review> _reviews = [
    Review(
      avatar: 'https://i.pravatar.cc/150?img=3',
      clientName: 'John Doe',
      description: 'Excellent service!',
      date: '1 day Ago',
      rating: 4.5,
    ),
    Review(
      avatar: 'https://i.pravatar.cc/150?img=3',
      clientName: 'Jane Smith',
      description: 'Very professional and helpful.',
      rating: 4.8,
      date: '1 Year Ago',
    ),
    Review(
      avatar: 'https://i.pravatar.cc/150?img=3',
      clientName: 'Jane Smith',
      description: 'Very professional and helpful.',
      rating: 4.8,
      date: '1 Year Ago',
    ),
    Review(
      avatar: 'https://i.pravatar.cc/150?img=3',
      clientName: 'Jane Smith',
      description: 'Very professional and helpful.',
      rating: 4.8,
      date: '1 Year Ago',
    ),
    // Add more reviews here
  ];
  final DateFormat formatter = DateFormat('yMMMMd');

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
                                  border:
                                      Border.all(color: Colors.white, width: 3),
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
                    child: Text(
                      widget.lawyerModel.fullNames,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF222B45),
                        fontSize: 20,
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
                          value:
                              widget.lawyerModel.appointments.length.toString(),
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
              alignment: Alignment.center,
              child: Text(
                "Lawyer About",
                overflow: TextOverflow.visible,
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
              alignment: Alignment.center,
              child: Text(
                "Lawyer employment history",
                overflow: TextOverflow.visible,
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
              alignment: Alignment.center,
              child: Text(
                "Lawyer Education",
                overflow: TextOverflow.visible,
                style: const TextStyle(
                  color: Color(0xff6B779A),
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 18, 25, 0),
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
              margin: const EdgeInsets.fromLTRB(25, 8, 25, 10),
              alignment: Alignment.topLeft,
              child: Text(
                "Available Time Slots",
                overflow: TextOverflow.visible,
                style: const TextStyle(
                  color: Color(0xff6B779A),
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 18, 25, 0),
              alignment: Alignment.topLeft,
              child: const Text(
                "Linked Accounts",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xff222B45),
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 13, 25, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 13, 0),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              color: const Color(0xffE8899E).withOpacity(0.15)),
                          child: const Icon(
                            EvaIcons.twitter,
                            color: Color(0xffE8899E),
                          )),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 13, 0),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              color: const Color(0xff7ACEFA).withOpacity(0.15)),
                          child: const Icon(
                            EvaIcons.linkedin,
                            color: Color(0xff7ACEFA),
                          )),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 13, 0),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              color: const Color(0xffF7C480).withOpacity(0.15)),
                          child: const Icon(
                            EvaIcons.facebook,
                            color: Color(0xffF7C480),
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: ExpansionPanelList(
                elevation: 0,
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                children: [
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return const ListTile(
                        title: Text(
                          'Reviews',
                          style: TextStyle(
                            color: Color(0xff222B45),
                            fontSize: 18,
                          ),
                        ),
                      );
                    },
                    body: Column(
                      children: _reviews
                          .map((review) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(review.avatar),
                                ),
                                title: Text(review.clientName),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(review.description),
                                    Row(
                                      children: [
                                        Row(
                                          children: List.generate(
                                              review.rating.round(), (index) {
                                            return const Icon(
                                              EvaIcons.star,
                                              color: Colors.amber,
                                              size: 15,
                                            );
                                          }),
                                        ),
                                        Spacer(),
                                        Text(review.date),
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                    isExpanded: _isExpanded,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                  ),
                  onPressed: () {
                    context.goNamed('bookingScreen');
                  },
                  child: const Text(
                    "Book Appointment",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )),
            ),
          ],
        ),
      ));
}
