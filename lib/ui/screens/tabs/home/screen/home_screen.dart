import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/bmi/bmi_provider.dart';
import '../widgets/result_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  bool _isLoadingMore = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then(
      (value) => Provider.of<BmiProvider>(context, listen: false).fetch(false),
    );
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchMore();
      }
    });

    super.initState();
  }

  void fetchMore() async {
    if (_isLoadingMore) {
      return;
    }
    _isLoadingMore = true;

    log('Fetching more records');

    // Fetch the next records
    await Provider.of<BmiProvider>(context, listen: false).fetch(true);

    _isLoadingMore = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'yourRecords'.tr(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          Consumer<BmiProvider>(
            builder: (context, bmiProvider, child) {
              if (bmiProvider.getIsLoading) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpinKitFadingFour(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                if (bmiProvider.getRecords.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/empty_primary.svg',
                            // height: 140,
                            width: 200,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'noDataFound'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: bmiProvider.getRecords.length,
                      itemBuilder: (context, index) => ResultCard(
                        index: index + 1,
                        bmiModel: bmiProvider.getRecords[index],
                      ),
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
