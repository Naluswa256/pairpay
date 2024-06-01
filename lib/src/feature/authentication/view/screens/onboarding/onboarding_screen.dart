import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sizzle_starter/src/feature/authentication/view/screens/onboarding/components/primary_button.dart';



class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
           children: [
               const SizedBox(height: 50,),
               Center(child: Image.asset('assets/images/Illustration.png')),
               const SizedBox(height: 30,),
              Center(child: Text('Explore App', style: Theme.of(context).textTheme.titleMedium,)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.\nVivamus enim nisl, convallis sed lectus sed', style: Theme.of(context).textTheme.bodySmall,),
                ),  
                const SizedBox(height: 30,),

                CustomButton(isFilled: true, buttonTitle: 'Login', onPressed: ()=>{

                }), 
                
                CustomButton(isFilled: false, buttonTitle: 'Create Account', onPressed: ()=>{

                }), 
                
              
               
           ],
        ),
      ),
    );
}