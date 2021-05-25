import 'package:user_app/theme/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

var fromsearch;

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController _searchfromTextEditingController = TextEditingController();

  @override
  void setState(fn) {
    fromsearch = _searchfromTextEditingController.text.toString().trim();
    // TODO: implement setState
    super.setState(fn);
  }
@override
  void dispose() {

    // TODO: implement dispose
    super.dispose();
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
                      fromsearch = _searchfromTextEditingController.text.toString().trim().toUpperCase();
                    });
                  },
                  controller: _searchfromTextEditingController,
                  keyboardType: TextInputType.streetAddress,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                  ),
                  placeholder: "From",
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


