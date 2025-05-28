import 'package:flutter/material.dart';
import '../widgets/header_widget.dart';
import '../widgets/branch_card.dart';
import '../widgets/error_message.dart';
import '../services/api_service.dart';
import '../widgets/app_scaffold.dart';
import '../l10n/app_localizations.dart';

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({super.key});

  @override
  State<BranchesScreen> createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  late Future<List<dynamic>> _branchesFuture;

  @override
  void initState() {
    super.initState();
    _loadBranches();
  }

  void _loadBranches() {
    _branchesFuture = ApiService.getBranches();
  }

  void _retry() {
    setState(() {
      _loadBranches();
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;
    final horizontalPadding = isWideScreen ? 24.0 : 16.0;

    return AppScaffold(
      title: local.branchesTitle,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(title: local.branchesTitle, alignment: TextAlign.left),
            const SizedBox(height: 8),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _branchesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    final error = snapshot.error;
                    if (error is ApiException) {
                      return ErrorMessage(
                        message: local.apiError(
                          error.statusCode.toString(),
                          error.message,
                        ),
                        onRetry: _retry,
                      );
                    } else {
                      return ErrorMessage(
                        message: local.unexpectedError(error.toString()),
                        onRetry: _retry,
                      );
                    }
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        local.branchesNotFound,
                        style: TextStyle(fontSize: screenWidth * 0.045),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  final branches = snapshot.data!;
                  return ListView.builder(
                    itemCount: branches.length,
                    itemBuilder: (context, index) {
                      final branch = branches[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: BranchCard(
                          address: branch['address'],
                          phone: branch['phone'],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
