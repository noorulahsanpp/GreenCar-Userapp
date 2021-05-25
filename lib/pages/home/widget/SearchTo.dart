import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:user_app/theme/style.dart';

var tosearch;

class SeachTo extends StatefulWidget {
  const SeachTo({Key key}) : super(key: key);

  @override
  _SeachToState createState() => _SeachToState();
}

class _SeachToState extends State<SeachTo> {

  static TextEditingController _searchtoTextEditingController = TextEditingController();
  @override
  void setState(fn) {
    tosearch = _searchtoTextEditingController.text.toString().trim().toUpperCase();
    // TODO: implement setState
    super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: Container(
          padding:EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Style.blacklight,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/fast_food/search.svg',
                color: Colors.white70,
                height: 25.0,
              ),
              Expanded(
                child: CupertinoTextField(
                  onChanged: (value) {
                    setState(() {
                      tosearch = _searchtoTextEditingController.text.toString().trim();
                    });
                  },
                  controller: _searchtoTextEditingController,
                  keyboardType: TextInputType.streetAddress,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(),
                  placeholder: "To...",
                  placeholderStyle: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(
                      color: Colors.white54, fontWeight: FontWeight.w300),
                  cursorColor: Style.yellow,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
