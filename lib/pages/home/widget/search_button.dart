import 'package:flutter/material.dart';
import 'package:user_app/pages/home/widget/SearchTo.dart';
import 'package:user_app/pages/home/widget/search.dart';
import 'package:user_app/pages/time_line_page.dart';
import 'package:user_app/theme/style.dart';

class SearchButton extends StatefulWidget {
  const SearchButton({Key key}) : super(key: key);

  @override
  _SearchButtonState createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {



  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 55.0, vertical: 5.0),
        child: Container(
          padding:EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
          decoration: BoxDecoration(
            color: Style.blacklight,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: RaisedButton(
                  child: Text("Search", style: TextStyle(
                    color: Colors.white70,
                    fontSize: 25
                  ),),
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  color: Style.blacklight,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> TimeLine(fromPlace:fromsearch.toUpperCase(),toPlace: tosearch.toUpperCase(),)));

                    print("${fromsearch}     ${tosearch}");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void search(){

  }
}
