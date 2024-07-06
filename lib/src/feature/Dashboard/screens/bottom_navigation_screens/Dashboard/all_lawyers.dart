

// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizzle_starter/src/feature/Dashboard/models/specialization_model.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/bloc/events/lawyer_event.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/bloc/lawyer_bloc.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/bloc/states/lawyer_state.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/dashboard_screen.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/widgets/lawyer_card.dart';
import 'package:sizzle_starter/src/feature/initialization/widget/dependencies_scope.dart';

class AllLawyerScreen extends StatefulWidget {
  final Specialization specialization;

  const AllLawyerScreen({
    Key? key,
    required this.specialization,
  }) : super(key: key);

  @override
  _AllLawyerScreenState createState() =>
      _AllLawyerScreenState();
}

class _AllLawyerScreenState extends State<AllLawyerScreen> {
  final ScrollController _scrollController = ScrollController();
  late LawyerBloc _lawyerBloc;
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  bool _hasMorePages = true;
  Timer? _searchDebounce;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _lawyerBloc =
        DependenciesScope.of(context).lawyerBloc;
    _lawyerBloc.add(FetchLawyers(page: 1, limit: 10, specializationId: widget.specialization.id));
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
        _lawyerBloc.add(
            FetchLawyers(page: _currentPage, limit: 10, specializationId: widget.specialization.id));
      }
    }
  }

   void _performSearch(String query) {
    // Handle search only when the user clicks the search icon
    if (_searchController.text.isNotEmpty && query.isEmpty) {
    } else if (query.isNotEmpty) {
      // Implement a delay before performing search to avoid frequent API calls while typing
      if (_searchDebounce?.isActive ?? false) _searchDebounce!.cancel();
      _searchDebounce = Timer(const Duration(milliseconds: 5000), () {
        _lawyerBloc.add(SearchLawyers(query: query, page: 1, limit: 10, specializationId: widget.specialization.id));
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xffFAFAFA),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xff222B45),
        ),
        title: Text(
          "All Lawyers in ${widget.specialization}",
          style: const TextStyle(
              color: Color(0xff222B45),
              fontFamily: "Poppins-SemiBold",
              fontSize: 16),
        ),
      ),
      body: BlocBuilder<LawyerBloc, LawyerState>(
        bloc: _lawyerBloc,
        builder: (context, state) {
          if (state is LawyerLoadSuccess) {
            return SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        // Handle search as user types
                        _performSearch(value);
                      },
                      decoration: InputDecoration(
                        fillColor:Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                          
                        ),
                        filled: true,
                        hintStyle: const TextStyle(color: Color(0xff6B779A), fontSize: 14),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  // Clear search text
                                  _searchController.clear();
                                  _performSearch('');
                                },
                              )
                            : IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: () {
                                  // Clear search text
                                  _searchController.clear();
                                  _performSearch(_searchController.text);
                                },
                              ),
                        contentPadding: const EdgeInsets.only(
                          left: 15,
                          bottom: 11,
                          top: 11,
                          right: 15,
                        ),
                        hintText: "Search For Specialization",
                      ),
                    ),
                  ),
                 if (state.lawyers.results.length < 0) Expanded(
                    child: GridView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5.0,
                      ),
                      itemCount: state.lawyers.results.length,
                      itemBuilder: (context, index) {
                        final lawyer =
                            state.lawyers.results[index];
                        return LawyerCard(
                          lawyerNames: lawyer.fullNames,
                          reviewCount: lawyer.numOfReviews,

                        );
                      },
                    ),
                  ) else Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  alignment: Alignment.center,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                        child: Icon(Icons.error_outline),
                      ),
                      Text(
                        'No results found',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                ],
              ),
            );
          } else if (state is LawyerLoadFailure) {
            final String errorMsg = state.error;

                final bool isNetworkError =
                    errorMsg.contains('ConnectionException');
            return CommonErrorPage(
              isForNetwork: isNetworkError,
              description: errorMsg,
              onRetry: () {
                _lawyerBloc.add(
                    FetchLawyers(page: _currentPage, limit: 10, specializationId: widget.specialization.id));
              },
            );
          } else {
            return CustomLoading.showWithStyle(context);
          }
        },
      ),
    );
}
