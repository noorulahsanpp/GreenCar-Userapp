import 'package:user_app/allscreens/registrationscreen.dart';
import 'package:user_app/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Header extends StatelessWidget {
  const Header({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 25.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hi, ${currentUser.name}',
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w800)),
                Text('Tell us how would you like save the world?',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(color: Colors.white54)),
              ],
            ),
            // Spacer(),
            // Container(
            //   height: 45.0,
            //   width: 45.0,
            //   padding: EdgeInsets.all(12.0),
            //   decoration: BoxDecoration(
            //     color: Style.blacklight,
            //     shape: BoxShape.circle,
            //   ),
            //   child: SvgPicture.asset(
            //     'assets/fast_food/bag.svg',
            //     color: Colors.white
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
