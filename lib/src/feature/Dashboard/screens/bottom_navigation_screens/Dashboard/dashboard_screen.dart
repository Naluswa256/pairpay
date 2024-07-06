// ignore_for_file: public_member_api_docs, unused_local_variable, lines_longer_than_80_chars

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sizzle_starter/src/core/constant/sizeConfig/size_config.dart';
import 'package:sizzle_starter/src/core/utils/logger.dart';
import 'package:sizzle_starter/src/feature/Dashboard/models/appointment_model.dart';
import 'package:sizzle_starter/src/feature/Dashboard/models/specialization_model.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bloc/dashboard_bloc.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bloc/dashboard_status/dashboard_status.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bloc/events/dashboard_event.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bloc/states/dashboard_state.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/widgets/upcoming_appointment_card.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/widgets/category_icon.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/widgets/lawyer_card.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/widgets/profile_avatar.dart';
import 'package:sizzle_starter/src/feature/app/model/app_theme.dart';
import 'package:sizzle_starter/src/feature/app/model/user_model.dart';
import 'package:sizzle_starter/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:sizzle_starter/src/feature/onboarding/data/local/user_local_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ThemeData themeData;
  User? _user;
  bool _isLoading = true;
  final UserService _userService = UserService();
  late HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _homeBloc = DependenciesScope.of(context).homeBloc;
    _homeBloc.add(const HomeCallTimelineSetupEvent());
  }

  Future<void> _loadUser() async {
    final User? user = await _userService.getUser();
    setState(() {
      _user = user;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    _homeBloc = DependenciesScope.of(context).homeBloc;
    MySize().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(27, 30, 27, 35),
          child: BlocConsumer<HomeBloc, HomeState>(
            buildWhen: (previous, current) {
              return previous.homeDashboardStatus !=
                  current.homeDashboardStatus;
            },
            listenWhen: (previous, current) {
              return previous.homeDashboardStatus !=
                  current.homeDashboardStatus;
            },
            builder: (context, state) {
              /// Home Completed State
              if (state.homeDashboardStatus is DashboardStatusCompleted) {
                final DashboardStatusCompleted cmPost =
                    state.homeDashboardStatus as DashboardStatusCompleted;

                final specializations =
                    cmPost.data['specializations'] as SpecializationResponse;
                final appointments = cmPost.data['appointmentsTodayByUser']
                    as AppointmentResponse;
                final popularLawyers =
                    cmPost.data['popularLawyers'] as UserResponse;
                logger.info(
                    'The length of popular Lawyers ${popularLawyers.results.length}');
                return LiquidPullToRefresh(
                  backgroundColor: Colors.white,
                  color: Theme.of(context).colorScheme.primary,
                  showChildOpacityTransition: true,
                  onRefresh: () async {
                    _homeBloc.add(HomeCallTimelineSetupEvent());
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_isLoading)
                            const CircularProgressIndicator()
                          else
                            Text(
                              "Welcome ${_user!.fullNames},",
                              style: AppThemeCustom.getTextStyle(
                                themeData.textTheme.titleMedium,
                                letterSpacing: 0.1,
                                color: Colors.black,
                              ),
                            ),
                          if (_isLoading)
                            const CircularProgressIndicator()
                          else
                            ProfileAvatar(
                              avatarUrl: _user!.avatar,
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Find your Lawyer",
                        style: AppThemeCustom.getTextStyle(
                          themeData.textTheme.headlineMedium,
                          letterSpacing: 0.1,
                          color: Colors.black,
                          fontWeight: 500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.goNamed('allLawyers'),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                          child: TextField(
                            enabled: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              hintStyle: const TextStyle(
                                color: Color(0xff6B779A),
                                fontSize: 14,
                              ),
                              suffixIcon: const Icon(Icons.search),
                              contentPadding: const EdgeInsets.only(
                                left: 15,
                                bottom: 11,
                                top: 11,
                                right: 15,
                              ),
                              hintText: "Search For Lawyer",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: MySize.size10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lawyer Specializations",
                            style: AppThemeCustom.getTextStyle(
                              themeData.textTheme.bodyMedium,
                              letterSpacing: 0.1,
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: 600,
                            ),
                          ),
                          TextButton(
                            onPressed: () => {
                              context.goNamed('allSpecializations',
                                  extra: specializations)
                            },
                            child: Text(
                              "View All",
                              style: AppThemeCustom.getTextStyle(
                                themeData.textTheme.titleLarge,
                                letterSpacing: 0.1,
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      CategoryIcons(
                        specializationResponse: specializations,
                      ),
                      SizedBox(height: MySize.size10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Appointment Today',
                            style: AppThemeCustom.getTextStyle(
                              themeData.textTheme.bodyMedium,
                              letterSpacing: 0.1,
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: 600,
                            ),
                          ),
                          TextButton(
                            child: Text(
                              'See All',
                              style: AppThemeCustom.getTextStyle(
                                themeData.textTheme.titleLarge,
                                letterSpacing: 0.1,
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                      SizedBox(height: MySize.size10),
                      if (appointments.results.isEmpty)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(
                              child: Icon(
                                Icons.calendar_month_outlined,
                                size: 48,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'No Appointments for today  yet',
                              style: AppThemeCustom.getTextStyle(
                                themeData.textTheme.bodyMedium,
                                letterSpacing: 0.1,
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: appointments.results.length,
                          itemBuilder: (context, index) {
                            final appointment = appointments.results[index];
                            return AppointmentCard(
                              appointment: appointment,
                              onTap: () {},
                            );
                          },
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Popular Lawyers',
                            style: AppThemeCustom.getTextStyle(
                              themeData.textTheme.bodyMedium,
                              letterSpacing: 0.1,
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: 600,
                            ),
                          ),
                          TextButton(
                            child: Text(
                              'See All',
                              style: AppThemeCustom.getTextStyle(
                                themeData.textTheme.titleLarge,
                                letterSpacing: 0.1,
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                      SizedBox(
                        height: 215,
                        child: ListView.builder(
                          // shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          //physics: const NeverScrollableScrollPhysics(),
                          itemCount: popularLawyers.results.length,
                          itemBuilder: (context, index) {
                            final lawyer = popularLawyers.results[index];
                            return GestureDetector(
                              onTap: () {
                                context.goNamed(
                                  'lawyerDetail',
                                  extra: lawyer,
                                );
                              },
                              child: LawyerCard(
                                lawyerNames: lawyer.fullNames,
                                reviewCount: lawyer.reviewsReceived.length,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }

              /// Home Error State
              if (state.homeDashboardStatus is DashboardStatusError) {
                final DashboardStatusError emPost =
                    state.homeDashboardStatus as DashboardStatusError;
                final String errorMsg = emPost.errorMsg;

                final bool isNetworkError =
                    errorMsg.contains('ConnectionException');

                return CommonErrorPage(
                  isForNetwork: isNetworkError,
                  description: errorMsg,
                  onRetry: () {
                    _homeBloc.add(const HomeCallTimelineSetupEvent());
                  },
                );
              }

              /// Home Loading State
              if (state.homeDashboardStatus is DashboardStatusLoading) {
                return CustomLoading.showWithStyle(context);
              }

              return Container();
            },
            listener: (BuildContext context, HomeState state) async {},
          ),
        ),
      ),
    );
  }
}

class CategoryIcons extends StatelessWidget {
  final SpecializationResponse specializationResponse;

  const CategoryIcons({
    Key? key,
    required this.specializationResponse,
  }) : super(key: key);

  // Define a map to assign icons based on specialization names
  static const Map<String, IconData> iconMap = {
    'General Law': Icons.gavel,
    'Family Law': Icons.family_restroom,
    'Corporate Law': Icons.business,
    'Criminal Law': Icons.security,
    'Tax Law': Icons.attach_money,
    'Immigration Law': Icons.airplanemode_active,
    'Environmental Law': Icons.eco,
    'Intellectual Property Law': Icons.gavel,
    'Employment Law': Icons.work,
    'Personal Injury Law': Icons.healing,
    'Real Estate Law': Icons.home,
    'Healthcare Law': Icons.local_hospital,
    'Contract Law': Icons.description,
    'Bankruptcy Law': Icons.account_balance,
    'Education Law': Icons.school,
    'Entertainment Law': Icons.movie,
    'Family and Juvenile Law': Icons.family_restroom,
    'Government Law': Icons.account_balance_wallet,
    'International Law': Icons.public,
    'Military Law': Icons.account_balance,
  };

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: specializationResponse.results.map((specialization) {
            final IconData icon =
                iconMap[specialization.name] ?? Icons.category;
            return CategoryIcon(
              icon: icon,
              text: specialization.name,
            );
          }).toList(),
        ),
      );
}

/// Custom App Loading styles
class CustomLoading {
  CustomLoading._();

  static Widget showWithStyle(
    BuildContext context,
  ) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CupertinoActivityIndicator(),
          const SizedBox(
            height: 4,
          ),
          Text(
            'LOADING...',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey[600]
                      : Colors.grey[800],
                ),
          ),
        ],
      );
}

class CommonErrorPage extends StatefulWidget {
  const CommonErrorPage(
      {super.key,
      required this.isForNetwork,
      required this.description,
      required this.onRetry});

  final bool isForNetwork;
  final String description;
  final VoidCallback onRetry;

  @override
  State<CommonErrorPage> createState() => _CommonErrorPageState();
}

class _CommonErrorPageState extends State<CommonErrorPage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.isForNetwork)
                const Icon(
                  EvaIcons.wifiOff,
                  size: 120,
                  color: Colors.grey,
                )
              else
                const Icon(
                  Icons.error_outline_rounded,
                  size: 120,
                  color: Colors.grey,
                ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Something went wrong!',
                style: theme.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  widget.description,
                  textAlign: TextAlign.center,
                  maxLines: 6,
                  style: theme.textTheme.labelLarge,
                ),
              ),
            ],
          ),
          TextButton.icon(
            onPressed: widget.onRetry,
            icon: const Icon(CupertinoIcons.refresh),
            label: const Text('Try Again'),
          )
        ],
      ),
    );
  }
}
