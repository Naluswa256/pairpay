import 'package:flutter/material.dart';
import 'package:sizzle_starter/src/core/constant/sizeConfig/size_config.dart';
import 'package:sizzle_starter/src/core/constant/theme/theme_constants.dart';
import 'package:sizzle_starter/src/feature/Dashboard/models/appointment_model.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg01),
        borderRadius: BorderRadius.circular(MySize.getScaledSizeHeight(10)),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(MySize.getScaledSizeHeight(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            color: Colors.white,
            size: MySize.getScaledSizeHeight(15),
          ),
          Space.width(5),
          Text(
            'Mon, July 29',
            style: TextStyle(color: Colors.white),
          ),
          Space.width(20),
          Icon(
            Icons.access_alarm,
            color: Colors.white,
            size: MySize.getScaledSizeHeight(17),
          ),
          Space.width(5),
          Flexible(
            child: Text(
              '11:00 ~ 12:10',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final void Function() onTap;

  const AppointmentCard({
    Key? key,
    required this.onTap,
    required this.appointment
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(MyColors.primary),
            borderRadius: BorderRadius.circular(MySize.getScaledSizeHeight(10)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.all(MySize.getScaledSizeHeight(20)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(appointment.lawyerId.avatar),
                        ),
                        Space.width(10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(appointment.lawyerId.fullNames,
                                style: TextStyle(color: Colors.white)),
                            Space.height(2),
                            Text(
                              'Civil Rights',
                              style: TextStyle(color: Color(MyColors.text01)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Space.height(20),
                    ScheduleCard(),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: MySize.getScaledSizeHeight(20)),
          width: double.infinity,
          height: MySize.getScaledSizeHeight(10),
          decoration: BoxDecoration(
            color: Color(MyColors.bg02),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(MySize.getScaledSizeHeight(10)),
              bottomLeft: Radius.circular(MySize.getScaledSizeHeight(10)),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: MySize.getScaledSizeHeight(40)),
          width: double.infinity,
          height: MySize.getScaledSizeHeight(10),
          decoration: BoxDecoration(
            color: Color(MyColors.bg03),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(MySize.getScaledSizeHeight(10)),
              bottomLeft: Radius.circular(MySize.getScaledSizeHeight(10)),
            ),
          ),
        ),
      ],
    );
  }
}
