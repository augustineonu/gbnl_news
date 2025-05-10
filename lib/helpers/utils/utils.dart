import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

String formatDate(dynamic dateInput) {
  // Handle cases where dateInput is not a valid DateTime
  DateTime date;

  try {
    if (dateInput is DateTime) {
      date = dateInput;
    } else if (dateInput is int) {
      // Assume int is a timestamp in milliseconds since epoch
      date = DateTime.fromMillisecondsSinceEpoch(dateInput);
    } else {
      // Default to current date if input can't be parsed
      date = DateTime.now();
    }
  } catch (e) {
    // Fallback to current date if any error occurs
    date = DateTime.now();
  }

  // Format the date as "DD MMMM YYYY" (e.g., "12 JUNE 2021")
  return '${date.day} ${DateFormat('MMMM').format(date).toUpperCase()} ${date.year}';
}

Future<void> openExternalUrl(String url) async {
  try {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  } catch (e) {
    print("error:: ${e.toString()}");
  }
}
