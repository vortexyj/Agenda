import 'package:agenda_v2/Screens/Additems.dart';
import 'package:agenda_v2/Screens/SettingsPage.dart';
import 'package:agenda_v2/Screens/SummaryPage.dart';

showwidget(int _page) {
  if (_page == 0) {
    return AddingitemsPage();
  } else if (_page == 1) {
    return SummaryPage();
  } else if (_page == 2) {
    return SettingsPage();
  }
}
