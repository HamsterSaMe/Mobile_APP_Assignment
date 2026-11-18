import 'package:flutter/material.dart';
import '../data/models.dart';

class PinReportsDialog extends StatelessWidget {
  final List<PinReportSummary> reports;

  const PinReportsDialog({super.key, required this.reports});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Reports (${reports.length})'),
      content: SizedBox(
        width: double.maxFinite,
        child: reports.isEmpty
            ? const Text('No reports for this section yet.')
            : ListView.builder(
                shrinkWrap: true,
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  final report = reports[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(report.title),
                    subtitle: Text(
                      'Reported: ${report.reportedAt.toLocal().toString().split('.')[0]}'
                      '${report.isSolved && report.resolvedAt != null ? '\nResolved: ${report.resolvedAt!.toLocal().toString().split('.')[0]}' : ''}',
                    ),
                    trailing: Chip(
                      label: Text(report.isSolved ? 'Solved' : 'Unsolved'),
                      backgroundColor: report.isSolved ? Colors.green[100] : Colors.red[100],
                    ),
                  );
                },
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
