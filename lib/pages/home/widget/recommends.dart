import 'package:user_app/allscreens/mainscreen.dart';
import 'package:user_app/models/cars_model.dart';
import 'package:user_app/models/ridedetailsmodel.dart';
import 'package:user_app/pages/detail/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:user_app/pages/home/home_page.dart';

class Recommends extends StatefulWidget {
  const Recommends({Key key}) : super(key: key);

  @override
  _RecommendsState createState() => _RecommendsState();
}

class _RecommendsState extends State<Recommends> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      sliver: SliverToBoxAdapter(
        child: AspectRatio(
          aspectRatio: 9 / 3.7,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: todayList.length,
            itemBuilder: (_, index) =>
                ItemRecommend(rideDetails: todayList[index], ii: index,),
          ),
        ),
      ),
    );
  }
}


// class Recommends extends StatelessWidget {
//   const Recommends({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//                 return SliverPadding(
//                   padding: EdgeInsets.symmetric(vertical: 10.0),
//                   sliver: SliverToBoxAdapter(
//                     child: AspectRatio(
//                       aspectRatio: 9 / 3.7,
//                       child: ListView.builder(
//                         physics: BouncingScrollPhysics(),
//                         scrollDirection: Axis.horizontal,
//                         itemCount: list.length,
//                         itemBuilder: (_, index) =>
//                             ItemRecommend(rideDetails: list[index]),
//                       ),
//                     ),
//                   ),
//                 );
//   }
// }

class ItemRecommend extends StatefulWidget {
  const ItemRecommend({Key key,
    @required this.rideDetails,this.ii
  }) : super(key: key);

  final RideDetails rideDetails;
  final int ii;

  @override
  _ItemRecommendState createState() => _ItemRecommendState();
}

class _ItemRecommendState extends State<ItemRecommend> {
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
        margin: EdgeInsets.only(left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 151.0,
                  width: 300.0,
                  margin: EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(listCars[widget.ii].imgUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                Positioned(
                  right: 0.0,
                  left: 0.0,
                  bottom: 9.5,
                  child: Container(
                    height: 60.0,
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.rideDetails.toplace,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.button.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "\$ ${widget.rideDetails.shareprice.toString()}",
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.button.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Positioned(
                //   top: 5.0,
                //   right: 5.0,
                //   child: Container(
                //     width: 40.0,
                //     height: 40.0,
                //     padding: EdgeInsets.all(8.0),
                //     decoration: BoxDecoration(
                //       color: Colors.black54,
                //       shape: BoxShape.circle,
                //     ),
                //     child: SvgPicture.asset(
                //       'assets/fast_food/favorite.svg',
                //       color: Colors.grey[200],
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

List<Car> _createCars() {
  List<Car> lista = [];

  lista.add(
    Car(
        id: 9,
        imgUrl: 'assets/images/car5.png',
        model: '2021',
        name: 'Supersonic LM'),
  );
  lista.add(
    Car(
        id: 10,
        imgUrl: 'assets/images/car6.png',
        model: '2021',
        name: 'Supersonic LM'),
  );
  lista.add(
    Car(
        id: 11,
        imgUrl: 'assets/images/car7.png',
        model: '2021',
        name: 'Supersonic LM'),
  );
  lista.add(
    Car(
        id: 12,
        imgUrl: 'assets/images/car13.png',
        model: '2021',
        name: 'Supersonic LM'),
  );
  lista.add(
    Car(
        id: 13,
        imgUrl: 'assets/images/car9.png',
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
        id: 5,
        imgUrl: 'assets/images/car4.png',
        model: '2021',
        name: 'Supersonic LM'),
  );
  lista.add(
    Car(
        id: 4,
        imgUrl: 'assets/images/car10.png',
        model: '2021',
        name: 'Supersonic LM'),
  );
  lista.add(
    Car(
        id: 6,
        imgUrl: 'assets/images/car11.png',
        model: '2021',
        name: 'Supersonic LM'),
  );
  lista.add(
    Car(
        id: 7,
        imgUrl: 'assets/images/car12.png',
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

// class ItemRecommend extends StatelessWidget {
//   const ItemRecommend({
//     Key key,
//     @required this.rideDetails,
//   }) : super(key: key);
//
//   final RideDetails rideDetails;
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
//         margin: EdgeInsets.only(left: 20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   height: 151.0,
//                   width: 300.0,
//                   margin: EdgeInsets.only(bottom: 10.0),
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage("assets/images/car6.png"),
//                       fit: BoxFit.cover,
//                     ),
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                 ),
//                 Positioned(
//                   right: 0.0,
//                   left: 0.0,
//                   bottom: 9.5,
//                   child: Container(
//                     height: 60.0,
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 15.0,
//                       vertical: 10.0,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.black54,
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(20.0),
//                         bottomRight: Radius.circular(20.0),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           rideDetails.seats,
//                           textAlign: TextAlign.left,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: Theme.of(context).textTheme.button.copyWith(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                               ),
//                         ),
//                         Text(
//                           "\$ ${rideDetails.seats.toString()}",
//                           textAlign: TextAlign.left,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: Theme.of(context).textTheme.button.copyWith(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w800,
//                                 fontSize: 20,
//                               ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // Positioned(
//                 //   top: 5.0,
//                 //   right: 5.0,
//                 //   child: Container(
//                 //     width: 40.0,
//                 //     height: 40.0,
//                 //     padding: EdgeInsets.all(8.0),
//                 //     decoration: BoxDecoration(
//                 //       color: Colors.black54,
//                 //       shape: BoxShape.circle,
//                 //     ),
//                 //     child: SvgPicture.asset(
//                 //       'assets/fast_food/favorite.svg',
//                 //       color: Colors.grey[200],
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
