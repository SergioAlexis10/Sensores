import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class GyroscopeBallScreen extends ConsumerWidget {
  const GyroscopeBallScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final gyroscope$ = ref.watch( gyroscopeProvider );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giroscópio'),
      ),
      body: SizedBox.expand(
        child: gyroscope$.when(
          data: (value) => MovingBall(x: value.x, y: value.y), 
          error: (error, stackTrace) => Text('$error'), 
          loading: () => const CircularProgressIndicator(),
        ),
      )
    );
    
  }
}


class MovingBall extends StatelessWidget {
  
  final double x;
  final double y;
  
  const MovingBall({super.key, required this.x, required this.y});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;

    double currentYPos = ( y * 150 );
    double currentXPos = ( x * 150 );


    return Stack(
      alignment: Alignment.center,
      children: [
        
        Positioned(
          left: ( screenWidth / 2 ) - 45,
          top: ( screenHeight / 2 ) - 110,
          child: const EmptyBall(),
        ),

        AnimatedPositioned(
          left: (currentYPos - 35) + ( screenWidth / 2 ),
          top: (currentXPos- 100) + ( screenHeight / 2 ),
          curve: Curves.easeInOut, 
          duration: const Duration(milliseconds: 1000),
          child: const Ball()
        ),
      ],
    );
  }
}


class Ball extends StatelessWidget {
  const Ball({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(100)
      ),
    );
  }
}

class EmptyBall extends StatelessWidget {
  const EmptyBall({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(100)
      ),
    );
  }
}