// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/bloc/events/lawyer_event.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/bloc/lawyer_bloc.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/bloc/states/lawyer_state.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/dashboard_screen.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/widgets/lawyer_card.dart';
import 'package:sizzle_starter/src/feature/initialization/widget/dependencies_scope.dart';

class SearchLawyerByNameScreen extends StatefulWidget {
  const SearchLawyerByNameScreen({Key? key}) : super(key: key);

  @override
  _SearchLawyerByNameScreenState createState() =>
      _SearchLawyerByNameScreenState();
}

class _SearchLawyerByNameScreenState extends State<SearchLawyerByNameScreen> {
  late LawyerBloc _lawyerBloc;
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  bool _hasMorePages = false; // Initially set to false
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _lawyerBloc = DependenciesScope.of(context).lawyerBloc;
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (_searchController.text.isNotEmpty && query.isEmpty) {
      // Handle clearing search results or any other specific action
    } else if (query.isNotEmpty) {
      if (_searchDebounce?.isActive ?? false) _searchDebounce!.cancel();
      _searchDebounce = Timer(const Duration(milliseconds: 500), () {
        _lawyerBloc.add(SearchLawyers(
          query: query,
          page: 1,
          limit: 10,
        ));
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
          title: const Text(
            "",
            style: TextStyle(
              color: Color(0xff222B45),
              fontFamily: "Poppins-SemiBold",
              fontSize: 16,
            ),
          ),
        ),
        body: BlocProvider(
          create: (context) => _lawyerBloc,
          child: Column(
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
                    hintStyle: const TextStyle(
                      color: Color(0xff6B779A),
                      fontSize: 14,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _performSearch('');
                            },
                          )
                        : IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
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
                    hintText: "Search For Lawyer",
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<LawyerBloc, LawyerState>(
                  builder: (context, state) {
                    if (state is LawyerLoadSuccess) {
                      _hasMorePages = _currentPage < state.lawyers.totalPages;

                      if (state.lawyers.results.isNotEmpty) {
                        return GridView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5.0,
                          ),
                          itemCount: state.lawyers.results.length,
                          itemBuilder: (context, index) {
                            final lawyer = state.lawyers.results[index];
                            return LawyerCard(
                              lawyerNames: lawyer.fullNames,
                              reviewCount: lawyer.numOfReviews,
                              // Add other properties as needed
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text('No results found'),
                        );
                      }
                    } else if (state is LawyerLoadFailure) {
                      final String errorMsg = state.error;
                      final bool isNetworkError =
                          errorMsg.contains('ConnectionException');
                      return CommonErrorPage(
                        isForNetwork: isNetworkError,
                        description: errorMsg,
                        onRetry: () {
                          _lawyerBloc.add(FetchLawyers(
                            page: _currentPage,
                            limit: 10,
                            specializationId:
                                '', // Adjust if needed based on your API requirements
                          ));
                        },
                      );
                    } else {
                      return CustomLoading.showWithStyle(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
}
