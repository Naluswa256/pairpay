import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "My Profile",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.logout, color:Colors.black),
                    onPressed: () {
                      // Add your logout logic here
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              const HorizontalLine(),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    foregroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('John Doe',
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Add your edit profile logic here
                            },
                          ),
                        ],
                      ),
                      Text('williamnaluswa@gmail.com',
                          style: TextStyle(
                            color: Colors.grey.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const SectionCard(
                header: "My Bookings",
                desc: "Already have 12 orders",
              ),
              const SectionCard(
                header: "My reviews",
                desc: "Reviews for 4 barbers",
              ),
              const SectionCard(
                header: "Settings",
                desc: "Notification, password",
              ),
              SectionCard(
                header: "Verify Phone Number",
                desc: "Verify your phone number",
                onTap: () {
                  // Add your verify phone number logic here
                },
              ),
              SectionCard(
                header: "Terms and Conditions",
                desc: "View terms and conditions",
                onTap: () {
                  // Add your terms and conditions logic here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  final String header;
  final String desc;
  final VoidCallback? onTap;
  
  const SectionCard({
    Key? key,
    required this.header,
    required this.desc,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(desc,
              style: TextStyle(
                color: Colors.grey.withOpacity(0.8),
              )),
          const SizedBox(height: 12),
          const HorizontalLine(),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 220, 218, 218),
            width: 0.9,
          ),
        ),
      ),
    );
  }
}
