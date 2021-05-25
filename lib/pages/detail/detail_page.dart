import 'package:user_app/data/models/food.dart';
import 'package:user_app/models/cars_model.dart';
import 'package:user_app/pages/detail/widget/button_appbar.dart';
import 'package:user_app/pages/detail/widget/information.dart';
import 'package:flutter/material.dart';
import 'package:user_app/models/ridedetailsmodel.dart';

import 'widget/header.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key key,this.tripid,this.ii,this.listCars,
    @required this.rideDetails,
  }) : super(key: key);

  final String tripid;
  final RideDetails rideDetails;
  final List<Car> listCars;
final int ii;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Stack(
          children: [
            ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.2],
                ).createShader(
                  Rect.fromLTRB(0, 0, rect.left, rect.height),
                );
              },
              blendMode: BlendMode.srcATop,
              child: Image.asset(listCars[ii].imgUrl,
                height: 530,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: -8,
              left: 20.0,
              right: 20.0,
              child: ButtonAppBar(),
            ),
            Positioned.fill(
              child: Column(
                children: [
                  Header(food: null),
                ],
              ),
            ),
            Information(
              rideDetails: rideDetails,
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