import 'package:flutter/material.dart';

class DoctorAppGridMenu extends StatelessWidget {
  const DoctorAppGridMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
      ),
      padding: EdgeInsets.zero,
      itemCount: doctorMenu.length,
      itemBuilder: (BuildContext context, index) {
        return GestureDetector(
          child: Container(
            constraints: const BoxConstraints(
              maxHeight: 81,
            ),
            child: Column(
              children: [
                Container(
                  constraints: const BoxConstraints(
                    minHeight: 56,
                    minWidth: 56,
                    maxHeight: 69,
                    maxWidth: 69,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(''),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Expanded(
                  child: Text(
                    doctorMenu[index].name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}




class DoctorMenu {
  String name;
  String image;

  DoctorMenu({this.name = '', this.image = ''});
}

var doctorMenu = [
  DoctorMenu(name: 'Consultation', image: 'assets/images/agreement.png'),
  DoctorMenu(name: 'Dental', image: 'assets/images/attorney.png'),
  DoctorMenu(name: 'Heart', image: 'assets/images/img_5.png'),
  DoctorMenu(name: 'Hospitals', image: 'assets/images/justice_14236674.png'),
  DoctorMenu(name: 'Medicines', image: 'assets/images/lawyer.png'),
  DoctorMenu(name: 'Physician', image: 'assets/images/mediation.png'),
  DoctorMenu(name: 'Skin', image: 'assets/images/assets_1907617.png'),
  DoctorMenu(name: 'Surgeon', image: 'assets/images/assets_1907617.png'),
];