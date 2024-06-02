import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomescreenHeader extends StatelessWidget {
  const HomescreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(children: [
            Text(
              'Find \nProfessional to\nConsult',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
            ),
            Spacer(),
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: 32,
            )
          ]),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SizedBox(
                height: 50,
                width: MediaQuery.sizeOf(context).width * 0.70,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Search for a professional......',
                      hintStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF7C7C7C), // Adjust hint text color
                      ),
                      fillColor: Theme.of(context).primaryColor,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: Color(0xFF7C7C7C),
                        size: 32,
                      )),
                ),
              ),
              Spacer(),
              Container(
                width: 46.0,
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Theme.of(context).primaryColor, // Adjust background color
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.filter_list),
                    color: Colors.black, onPressed: () {}, // Adjust icon color
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15,),
        ],
      ),
    );
  }
}
