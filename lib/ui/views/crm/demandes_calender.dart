import '/core/enums/view_states.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '/ui/shared/navigation_router_paths.dart';
import '/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Callender extends StatefulWidget {
  const Callender({
    Key? key,
  }) : super(key: key);
  @override
  _Callender createState() => _Callender();
}

class _Callender extends State<Callender> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushReplacementNamed(
                  context,
                  NavigationRouterPaths.Home_View,
                )),
        title: const Text('Calendrier'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SfCalendar(
              view: CalendarView.schedule,
            ),
            CustomButton(
              buttonText: "List View",
              onPressAction: () {
                Navigator.pushReplacementNamed(
                    context, NavigationRouterPaths.Demandes_Activity_list);
              },
            )
          ],
        ),
      ),
    );
  }
}
