import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/admin/components/side_menu.dart';
import 'package:freelance_app/presentation/admin/screens/dashboard/components/my_feilds.dart';
import 'package:freelance_app/responsive.dart';

import 'components/header.dart';
import 'components/recent_job.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 300,
        ),
        child: SideMenu(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(),
            SizedBox(
              height: kDefaultPadding/2,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      MyFields(),
                      SizedBox(height: kDefaultPadding),
                      RecentJobs(),
                      if(Responsive.isMobile(context))
                        SizedBox(height: kDefaultPadding),

                    ],
                  ),
                ),
                if(!Responsive.isMobile(context))
                SizedBox(width: kDefaultPadding),

              ],
            )
          ],
        ),
      ),
    );
  }


}
