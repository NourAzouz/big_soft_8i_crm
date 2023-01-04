import 'package:big_soft_8i_crm/ui/views/crm/activity/activity_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'activity_details_view.dart';

class ActivityDetailsTabView extends StatelessWidget {
  final activity;
  const ActivityDetailsTabView({Key? key, required this.activity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(activity.title),
          bottom: const TabBar(
            tabs: [
              Tab(text: "INFORMATIONS"),

              //Tab(text: "ARTICLES"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ActivityDetailsView(
              ActivityDetailsViewArguments: activity.code,
            ),
          ],
        ),
      ),
    );
  }
}
