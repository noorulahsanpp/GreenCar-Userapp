import 'package:user_app/models/cars_model.dart';
import 'package:user_app/models/ridedetailsmodel.dart';
import 'package:user_app/pages/detail/detail_page.dart';
import 'package:user_app/pages/home/home_page.dart';
import 'package:user_app/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Offers extends StatefulWidget {
  const Offers({Key key}) : super(key: key);

  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding:
      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      sliver: SliverToBoxAdapter(
        child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: list.length,
          itemBuilder: (_, index) =>
              ItemOffer(rideDetails: list[index], ii:index,),
        ),
      ),
    );
  }
}


// class Offers extends StatelessWidget {
//   const Offers({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//                 return SliverPadding(
//                   padding:
//                       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                   sliver: SliverToBoxAdapter(
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       physics: BouncingScrollPhysics(),
//                       scrollDirection: Axis.vertical,
//                       itemCount: list.length,
//                       itemBuilder: (_, index) =>
//                           ItemOffer(rideDetails: list[index]),
//                     ),
//                   ),
//                 );
//   }
// }


class ItemOffer extends StatefulWidget {
  const ItemOffer({
    Key key,
    @required this.rideDetails,this.ii
  }) : super(key: key);

  final RideDetails rideDetails;
  final int ii;


  @override
  _ItemOfferState createState() => _ItemOfferState();
}

class _ItemOfferState extends State<ItemOffer> {

  List<Car> listCars;
  @override

  Widget build(BuildContext context) {
    listCars = _createCars();
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DetailPage(
            rideDetails: widget.rideDetails,ii: widget.ii,listCars: listCars,
          ),
        ),
      ),
      child: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 120.0,
                  margin: EdgeInsets.only(bottom: 15.0),
                  decoration: BoxDecoration(
                    color: Style.blacklight,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 10,
                        child: Transform.rotate(
                          angle: 4.68,
                          // child: Text(
                          //   "${widget.rideDetails.date}",
                          //   textAlign: TextAlign.left,
                          //   maxLines: 1,
                          //   overflow: TextOverflow.ellipsis,
                          //   style: Theme.of(context).textTheme.button.copyWith(
                          //       color: Colors.white70,
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: 18.0),
                          // ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10.0, right: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                widget.rideDetails.toplace,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              Text(
                                widget.rideDetails.date,
                                textAlign: TextAlign.justify,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                    color: Colors.white70, fontSize: 14),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  _icons(
                                    context,
                                    'assets/fast_food/money.svg',
                                    widget.rideDetails.shareprice.toString(),
                                  ),
                                  _icons(
                                    context,
                                    'assets/fast_food/timer.svg',
                                    widget.rideDetails.seats,
                                  ),
                                  _icons(
                                    context,
                                    'assets/fast_food/star.svg',
                                    widget.rideDetails.seats,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 120.0,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            image: AssetImage(listCars[widget.ii].imgUrl),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



// class ItemOffer extends StatelessWidget {
//   const ItemOffer({
//     Key key,
//     @required this.rideDetails,this.ii
//   }) : super(key: key);
//
//   final RideDetails rideDetails;
//   final int ii;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => DetailPage(
//             rideDetails: rideDetails,
//           ),
//         ),
//       ),
//       child: Container(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   height: 120.0,
//                   margin: EdgeInsets.only(bottom: 15.0),
//                   decoration: BoxDecoration(
//                     color: Style.blacklight,
//                     borderRadius: BorderRadius.circular(15.0),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                         width: 56,
//                         child: Transform.rotate(
//                           angle: 4.68,
//                           child: Text(
//                             "Hello",
//                             textAlign: TextAlign.left,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: Theme.of(context).textTheme.button.copyWith(
//                                 color: Colors.white70,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18.0),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               top: 10.0, bottom: 10.0, right: 15.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Text(
//                                 rideDetails.seats,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .caption
//                                     .copyWith(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 18.0),
//                               ),
//                               Text(
//                                 rideDetails.hostid,
//                                 textAlign: TextAlign.justify,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .caption
//                                     .copyWith(
//                                         color: Colors.white70, fontSize: 14),
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   _icons(
//                                     context,
//                                     'assets/fast_food/money.svg',
//                                     rideDetails.shareprice.toString(),
//                                   ),
//                                   _icons(
//                                     context,
//                                     'assets/fast_food/timer.svg',
//                                     rideDetails.seats,
//                                   ),
//                                   _icons(
//                                     context,
//                                     'assets/fast_food/star.svg',
//                                     rideDetails.seats,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: 100.0,
//                         height: double.infinity,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15.0),
//                           image: DecorationImage(
//                             image: AssetImage(listCars[ii].imgUrl),
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

Widget _icons(BuildContext context, String path, String information) {
  return Row(
    children: [
      SvgPicture.asset(
        path,
        color: Style.yellow,
        width: 18.0,
        height: 18.0,
      ),
      SizedBox(width: 5.0),
      Text(
        information,
        style: Theme.of(context)
            .textTheme
            .button
            .copyWith(color: Colors.white, fontSize: 15),
      ),
    ],
  );
}
List<Car> _createCars() {
  List<Car> lista = [];

  lista.add(
    Car(
        id: 9,
        imgUrl: 'assets/images/car9.png',
        model: '2021',
        name: 'Supersonic LM'),
  );
  lista.add(
    Car(
        id: 10,
        imgUrl: 'assets/images/car10.png',
        model: '2021',
        name: 'Supersonic LM'),
  );
  lista.add(
    Car(
        id: 11,
        imgUrl: 'assets/images/car11.png',
        model: '2021',
        name: 'Supersonic LM'),
  );
  lista.add(
    Car(
        id: 12,
        imgUrl: 'assets/images/car12.png',
        model: '2021',
        name: 'Supersonic LM'),
  );
  lista.add(
    Car(
        id: 13,
        imgUrl: 'assets/images/car13.png',
        model: '2021',
        name: 'Supersonic LM'),
  );
  lista.add(
    Car(
        id: 1,
        imgUrl: 'assets/images/car1.png',
        model: '2021',
        name: 'Combat XM'),
  );
  lista.add(
    Car(
        id: 2,
        imgUrl: 'assets/images/car2.png',
        model: '2020',
        name: 'Supreme'),
  );
  lista.add(
    Car(
        id: 3,
        imgUrl: 'assets/images/car3.png',
        model: '2021',
        name: 'XMM Turbo'),
  );
  lista.add(
    Car(
        id: 4,
        imgUrl: 'assets/images/car4.png',
        model: '2021',
        name: 'Supersonic LM'),
  );
  lista.add(
    Car(
        id: 5,
        imgUrl: 'assets/images/car5.png',
        model: '2021',
        name: 'Supersonic LM'),
  );
  lista.add(
    Car(
        id: 6,
        imgUrl: 'assets/images/car6.png',
        model: '2021',
        name: 'Supersonic LM'),
  );
  lista.add(
    Car(
        id: 7,
        imgUrl: 'assets/images/car7.png',
        model: '2021',
        name: 'Supersonic LM'),
  );
  lista.add(
    Car(
        id: 8,
        imgUrl: 'assets/images/car8.png',
        model: '2021',
        name: 'Supersonic LM'),
  );

  return lista;
}