import 'package:flutter/material.dart';
import 'package:flutter_smarthome/view_model/switch_provider.dart';
import 'package:flutter_smarthome/view/color/colors.dart';
import 'package:provider/provider.dart';

class CustomCard3 extends StatefulWidget {
  CustomCard3({super.key, required this.color, required this.title});

  final Color color;
  final String title;

  @override
  State<CustomCard3> createState() => _CustomCard3State();
}

class _CustomCard3State extends State<CustomCard3>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Alignment> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );

    _animation = Tween<Alignment>(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
        reverseCurve: Curves.easeInBack,
      ),
    );
    awal();
    super.initState();
  }

  void awal() {
    if (_animationController.isCompleted) {
      _animationController.animateTo(20);
    } else {
      _animationController.animateTo(0);
    }
  }

  bool test = false;
  @override
  Widget build(BuildContext context) {
    final switchprovider = Provider.of<SwitchProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 150,
      width: size.width * 0.4,
      decoration: BoxDecoration(
        color: card3,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(3, 3),
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  size: 60,
                  color: Colors.white,
                ),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (animation, child) {
                    return GestureDetector(
                      onTap: () {
                        awal();
                        test = !test;
                        switchprovider.lamp = test;
                      },
                      child: Container(
                        height: 40,
                        width: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade50,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 0,
                              offset: Offset(3, 3),
                            ),
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 1,
                              offset: Offset(-3, -3),
                            ),
                          ],
                        ),
                        child: Align(
                          alignment: _animation.value,
                          child: Container(
                            height: 18,
                            width: 18,
                            margin: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 1),
                            decoration: BoxDecoration(
                              color: widget.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              switchprovider.lampTxt,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// onTap: () {
//                         setState(() {
//                           if (_animationController.isCompleted) {
//                             _animationController.animateTo(20);
//                           } else {
//                             _animationController.animateTo(0);
//                           }
//                         });