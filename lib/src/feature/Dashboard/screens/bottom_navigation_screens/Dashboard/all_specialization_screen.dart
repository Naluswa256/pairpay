// ignore_for_file: inference_failure_on_instance_creation

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizzle_starter/src/feature/Dashboard/models/specialization_model.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/all_lawyers.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/bloc/all_specialization_bloc.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/bloc/events/specialization_event.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/bloc/states/specialization_state.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/dashboard_screen.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/widgets/category_icon.dart';
import 'package:sizzle_starter/src/feature/initialization/widget/dependencies_scope.dart';

class AllSpecializationsScreen extends StatefulWidget {
  final SpecializationResponse specializationResponse;

  const AllSpecializationsScreen({
    Key? key,
    required this.specializationResponse,
  }) : super(key: key);

  @override
  _AllSpecializationsScreenState createState() =>
      _AllSpecializationsScreenState();
}

class _AllSpecializationsScreenState extends State<AllSpecializationsScreen> {
  final ScrollController _scrollController = ScrollController();
  late SpecializationBloc _specializationBloc;
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  bool _hasMorePages = true;
  Timer? _searchDebounce;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _specializationBloc = DependenciesScope.of(context).specializationBloc;
    _specializationBloc.add(
      LoadSpecializationsFromCache(
        specializationResponse: widget.specializationResponse,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchDebounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_hasMorePages) {
        _currentPage++;
        _specializationBloc.add(
          FetchSpecializations(page: _currentPage, limit: 10),
        );
      }
    }
  }

  void _performSearch(String query) {
    if (_searchController.text.isNotEmpty && query.isEmpty) {
      _specializationBloc.add(
        LoadSpecializationsFromCache(
          specializationResponse: widget.specializationResponse,
        ),
      );
    } else if (query.isNotEmpty) {
      if (_searchDebounce?.isActive ?? false) _searchDebounce!.cancel();
      _searchDebounce = Timer(Duration(milliseconds: 5000), () {
        _specializationBloc
            .add(SearchSpecializations(query: query, page: 1, limit: 10));
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xffFAFAFA),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Color(0xff222B45),
          ),
          title: Text(
            "All Lawyer Specializations",
            style: TextStyle(
              color: Color(0xff222B45),
              fontFamily: "Poppins-SemiBold",
              fontSize: 16,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  _performSearch(value);
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Color(0xff6B779A), fontSize: 14),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _performSearch('');
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            _searchController.clear();
                            _performSearch(_searchController.text);
                          },
                        ),
                  contentPadding: EdgeInsets.only(
                    left: 15,
                    bottom: 11,
                    top: 11,
                    right: 15,
                  ),
                  hintText: "Search For Specialization",
                ),
              ),
            ),
            Expanded(
              child: BlocListener<SpecializationBloc, SpecializationState>(
                bloc: _specializationBloc,
                listener: (context, state) {
                  // if (state is SpecializationLoadFailure) {
                  //   final String errorMsg = state.error;
                  //   final bool isNetworkError =
                  //       errorMsg.contains('ConnectionException');
                  //   if (isNetworkError) {
                  //     _specializationBloc.add(LoadSpecializationsFromCache(
                  //       specializationResponse: widget.specializationResponse,
                  //     ));
                  //   }
                  // }
                },
                child: BlocBuilder<SpecializationBloc, SpecializationState>(
                  bloc: _specializationBloc,
                  builder: (context, state) {
                    if (state is SpecializationLoadSuccess) {
                      return GridView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        controller: _scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5.0,
                        ),
                        itemCount: state.specializations.results.length,
                        itemBuilder: (context, index) {
                          final specialization =
                              state.specializations.results[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => AllLawyerScreen(specialization: specialization),
                                ),
                              );
                            },
                            child: CategoryIcon(
                              icon:
                                  CategoryIcons.iconMap[specialization.name] ??
                                      Icons.category,
                              text: specialization.name,
                            ),
                          );
                        },
                      );
                    } else if (state is SpecializationLoadFailure) {
                      final String errorMsg = state.error;
                      final bool isNetworkError =
                          errorMsg.contains('ConnectionException');
                      return CommonErrorPage(
                        isForNetwork: isNetworkError,
                        description: isNetworkError
                            ? 'No Internet Connection'
                            : errorMsg,
                        onRetry: () {
                          _specializationBloc.add(
                            FetchSpecializations(
                              page: _currentPage,
                              limit: 10,
                            ),
                          );
                        },
                      );
                    } else {
                      return CustomLoading.showWithStyle(context);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      );
}
